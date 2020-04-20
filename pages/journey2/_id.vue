<template>
  <section id="journey">
    <div>
      <v-btn small text nuxt exact to="/journey2">
        <v-icon left>mdi-arrow-left</v-icon>
        Outcomes
      </v-btn>
    </div>

    <div class="px-3 mt-4">
      <h1 class="headline">
        {{ outcome.title }}
      </h1>
      <h2 class="title mt-2 primary--text text--lighten-3">
        Choose your path
      </h2>
    </div>

    <div class="mt-4">
      <v-card color="rgb(0, 0, 0, 0.01)">
        <v-list class="pa-0" color="rgb(0, 0, 0, 0.02)">
          <template v-for="(p, index) in paths">
            <v-list-item
              :key="p.id"
              link
              nuxt
              :to="`/journey2/${outcome.id}/paths/${p.id}`"
            >
              <v-list-item-content>
                <v-list-item-title
                  class="font-weight-bold"
                  v-text="p.title"
                ></v-list-item-title>
              </v-list-item-content>
            </v-list-item>

            <v-divider v-if="index + 1 < paths.length" :key="index"></v-divider>
          </template>
        </v-list>
      </v-card>
    </div>
  </section>
</template>

<script>
import lodash from 'lodash'
import db from '@/data/journey2.json'

export default {
  asyncData({ params, error }) {
    const id = params.id

    if (!id) {
      error({ statusCode: 500, message: 'Oops. Something went wrong.' })
      return
    }

    const outcome = db.outcomes.find((o) => o.id === id)

    if (!outcome) {
      error({ statusCode: 404, message: 'Not found' })
      return
    }

    const paths = lodash.filter(db.paths, (p) =>
      lodash.includes(p.outcomes, outcome.id)
    )

    return { outcome, paths }
  }
}
</script>

<style></style>
