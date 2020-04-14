<template>
  <section class="id">
    <v-fade-transition hide-on-leave>
      <div v-if="!selectedOutcome && !selectedPath">
        <div v-if="user" class="pb-2">
          <div class="d-flex justify-center">
            <v-btn color="primary" x-small @click="signOut">
              Sign out
            </v-btn>
          </div>
          <v-card color="info lighten-2 mt-4">
            <v-card-title class="title">Your progress</v-card-title>
            <v-card-text>
              <div v-if="isExistingUser">
                <h4 class="subtitle-2 mb-2">
                  Current
                </h4>
                <path-item
                  :path="getPath(existingUserProgressData.current.id)"
                  @select="selectPath"
                ></path-item>

                <h4 class="subtitle-2 mt-4 mb-2">
                  Others in progress
                </h4>
                <div
                  v-for="p in existingUserProgressData.incomplete"
                  :key="p.id"
                  class="mb-2"
                >
                  <path-item
                    :path="getPath(p.id)"
                    @select="selectPath"
                  ></path-item>
                </div>

                <v-expansion-panels flat accordion class="mt-4">
                  <v-expansion-panel>
                    <v-expansion-panel-header>
                      Finished
                    </v-expansion-panel-header>
                    <v-expansion-panel-content>
                      <div
                        v-for="p in existingUserProgressData.finished"
                        :key="p.id"
                        class="mb-2"
                      >
                        <path-item
                          :path="getPath(p.id)"
                          @select="selectPath"
                        ></path-item>
                      </div>
                    </v-expansion-panel-content>
                  </v-expansion-panel>
                </v-expansion-panels>
              </div>

              <div v-else>
                <v-expand-transition>
                  <div>
                    <div v-if="favouriteOutcomesList.length">
                      <h4 class="subtitle-2 mb-2">
                        Suggested path
                      </h4>
                      <path-item
                        :path="suggestedPath"
                        @select="selectPath"
                      ></path-item>
                    </div>
                    <div v-else>
                      <p class="body-1">Hello! Thanks for signing in.</p>
                      <p class="body-1 mb-0">
                        Choose the outcomes you want to focus on by clicking on
                        the heart(s) below and we'll suggest paths for you to
                        follow.
                      </p>
                    </div>
                  </div>
                </v-expand-transition>
              </div>
            </v-card-text>
          </v-card>
        </div>
        <div v-else class="d-flex justify-center">
          <v-btn color="primary" x-small @click="signInNew">
            Sign in new user
          </v-btn>
          <v-btn color="primary" x-small class="ml-2" @click="signInExisting">
            Sign in existing user
          </v-btn>
        </div>

        <h1 class="headline mt-4 px-3">What does justice look like for you?</h1>
      </div>
      <div v-else-if="selectedPath && selectedOutcome">
        <v-btn text @click="backToOutcome">
          <v-icon left>mdi-arrow-left</v-icon>
          Back
        </v-btn>
      </div>
      <div v-else>
        <v-btn text @click="backToHome">
          <v-icon left>mdi-arrow-left</v-icon>
          Back
        </v-btn>
      </div>
    </v-fade-transition>

    <div class="mt-4">
      <v-fade-transition hide-on-leave>
        <div v-if="!selectedOutcome && !selectedPath">
          <v-card class="mt-3">
            <v-list class="pa-0">
              <template v-for="(o, index) in db.outcomes">
                <v-list-item
                  :key="o.id"
                  :ripple="false"
                  @click="selectOutcome(o)"
                >
                  <v-list-item-icon class="mr-4">
                    <v-btn
                      fab
                      dark
                      small
                      color="primary"
                      elevation="0"
                      style="flex: none"
                    >
                      <v-icon dark>mdi-{{ icons[o.id] || defaultIcon }}</v-icon>
                    </v-btn>
                  </v-list-item-icon>

                  <v-list-item-content>
                    <v-list-item-title
                      class="font-weight-bold"
                      v-text="o.title"
                    ></v-list-item-title>
                  </v-list-item-content>

                  <v-list-item-action v-if="user">
                    <v-fade-transition hide-on-leave>
                      <v-btn
                        v-if="user.favouriteOutcomes[o.id]"
                        icon
                        color="accent"
                        :ripple="false"
                        @click.stop="unfavourite(o)"
                      >
                        <v-icon>
                          mdi-heart
                        </v-icon>
                      </v-btn>
                      <v-btn
                        v-else
                        icon
                        color="accent"
                        :ripple="false"
                        @click.stop="favourite(o)"
                      >
                        <v-icon>
                          mdi-heart-outline
                        </v-icon>
                      </v-btn>
                    </v-fade-transition>
                  </v-list-item-action>
                </v-list-item>

                <v-divider
                  v-if="index + 1 < db.outcomes.length"
                  :key="index"
                ></v-divider>
              </template>
            </v-list>
          </v-card>
        </div>
        <div v-else-if="selectedPath" class="px-3">
          <h1 class="headline">
            {{ selectedPath.title }}
          </h1>
          <h2
            v-if="selectedPath.subtitle"
            class="subtitle-1 grey--text text--darken-1"
          >
            {{ selectedPath.subtitle }}
          </h2>
          <p v-if="selectedPath.description" class="body-2">
            {{ selectedPath.description }}
          </p>

          <div v-if="user" class="d-flex justify-center">
            <v-btn color="primary">
              Start this path
            </v-btn>
          </div>
        </div>
        <div v-else>
          <h1 class="headline mb-6">
            {{ selectedOutcome.title }}
          </h1>
          <h4 class="subtitle-2 mb-2">
            Available paths
          </h4>
          <div
            v-for="p in pathsForOutcome(selectedOutcome)"
            :key="p.id"
            class="mb-2"
          >
            <path-item :path="p" @select="selectPath"></path-item>
          </div>
        </div>
      </v-fade-transition>
    </div>
  </section>
</template>

<script>
import lodash from 'lodash'
import db from '@/data/paths.json'

import PathItem from '@/components/PathItem'

const existingUserProgressData = {
  favouriteOutcomes: { 'reclaim-myself': true, 'telling-partner': true },
  current: {
    id: 'trauma-resilience'
  },
  incomplete: [{ id: 'exercises-ground-you' }],
  finished: [{ id: 'forget' }, { id: 'feel-safe' }]
}

export default {
  components: { PathItem },
  data() {
    return {
      db,
      user: null,
      isExistingUser: false,
      existingUserProgressData,
      selectedOutcome: null,
      selectedPath: null,
      defaultIcon: 'ballot',
      icons: {
        'reclaim-myself': 'bottle-tonic-plus',
        'legal-conviction': 'gavel',
        'telling-friend-family': 'account-multiple',
        'telling-partner': 'account-heart',
        'moving-on': 'account-arrow-right',
        'rebuilding-trust': 'account-lock',
        'mental-health-recovery': 'head-check',
        'self-acceptance-love': 'head-heart'
      }
    }
  },
  computed: {
    favouriteOutcomesList() {
      if (!this.user) return null

      return lodash.filter(this.user.favouriteOutcomes, (v, k) => v)
    },
    suggestedPath() {
      return db.paths[0]
    }
  },
  methods: {
    signInNew() {
      this.isExistingUser = false
      this.user = {
        favouriteOutcomes: {}
      }
    },
    signInExisting() {
      this.isExistingUser = true
      this.user = {
        favouriteOutcomes: existingUserProgressData.favouriteOutcomes
      }
    },
    signOut() {
      this.isExistingUser = false
      this.user = null
    },
    backToHome() {
      this.selectedOutcome = null
      this.selectedPath = null
    },
    backToOutcome() {
      this.selectedPath = null
    },
    selectOutcome(o) {
      this.selectedOutcome = o
    },
    selectPath(p) {
      this.selectedPath = p
    },
    favourite(o) {
      this.$set(this.user.favouriteOutcomes, o.id, true)
    },
    unfavourite(o) {
      this.$set(this.user.favouriteOutcomes, o.id, false)
    },
    getPath(id) {
      return lodash.find(db.paths, ['id', id])
    },
    pathsForOutcome(o) {
      return lodash.filter(db.paths, (p) => lodash.includes(p.outcomes, o.id))
    }
  }
}
</script>

<style></style>
