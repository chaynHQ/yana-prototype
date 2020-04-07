<template>
  <section class="id">
    <div v-if="!selected" class="px-3">
      <h1 class="headline">What does justice look like for you?</h1>
    </div>
    <div v-else>
      <v-btn text @click="back">
        <v-icon left>mdi-arrow-left</v-icon>
        Back
      </v-btn>
    </div>

    <div class="mt-4">
      <div v-if="!selected">
        <div v-if="user">
          <v-card outlined>
            <v-card-text>
              Hello!
            </v-card-text>
          </v-card>
        </div>
        <div v-else class="d-flex justify-center">
          <v-btn color="primary" @click="signIn">Sign in</v-btn>
        </div>

        <v-card class="mt-3">
          <h2 v-if="user" class="subtitle-2 pa-3">
            Choose the outcomes you want to focus on by clicking on the heart
          </h2>

          <v-divider v-if="user"></v-divider>

          <v-list class="pa-0">
            <template v-for="(o, index) in paths.outcomes">
              <v-list-item :key="o.id" :ripple="false" @click="select(o)">
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
                  <v-btn
                    v-if="user.favourites[o.id]"
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
                </v-list-item-action>
              </v-list-item>

              <v-divider
                v-if="index + 1 < paths.outcomes.length"
                :key="index"
              ></v-divider>
            </template>
          </v-list>
        </v-card>
      </div>
      <div v-else></div>
    </div>
  </section>
</template>

<script>
import paths from '@/data/paths.json'

export default {
  data() {
    return {
      selected: null,
      user: null,
      paths,
      defaultIcon: 'ballot',
      icons: {
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
  methods: {
    signIn() {
      this.user = {
        favourites: {}
      }
    },
    back() {
      this.selected = null
    },
    select(o) {
      this.selected = o
    },
    favourite(o) {
      this.$set(this.user.favourites, o.id, true)
    },
    unfavourite(o) {
      this.$set(this.user.favourites, o.id, false)
    }
  }
}
</script>

<style></style>
