<template>
  <section id="journeys">
    <div class="px-3">
      <h1 class="headline">Journey to justice</h1>
      <h2 class="title mt-2 primary--text text--lighten-3">
        What can we help you with?
      </h2>
    </div>

    <div class="mt-4">
      <v-card color="rgb(0, 0, 0, 0.01)">
        <v-list class="pa-0" color="rgb(0, 0, 0, 0.02)">
          <template v-for="(o, index) in outcomes">
            <v-list-item :key="o.id" link nuxt :to="`/journey2/${o.id}`">
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
            </v-list-item>

            <v-divider
              v-if="index + 1 < outcomes.length"
              :key="index"
            ></v-divider>
          </template>
        </v-list>
      </v-card>
    </div>
  </section>
</template>

<script>
import db from '@/data/journey2.json'

export default {
  data() {
    return {
      outcomes: db.outcomes,
      defaultIcon: 'ballot',
      icons: {
        'telling-someone': 'account-heart',
        'reconnecting-moving-on': 'bottle-tonic-plus',
        accountable: 'gavel'
      }
    }
  }
}
</script>

<style></style>
