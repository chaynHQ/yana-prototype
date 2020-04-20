<template>
  <section id="path">
    <div>
      <v-btn small text nuxt exact :to="`/journey2/${outcomeId}`">
        <v-icon left>mdi-arrow-left</v-icon>
        Paths
      </v-btn>
    </div>

    <div class="px-3 mt-4">
      <h1 class="headline">
        {{ path.title }}
      </h1>
    </div>

    <div class="mt-4"></div>
  </section>
</template>

<script>
import lodash from 'lodash'
import db from '@/data/journey2.json'

export default {
  asyncData({ params, error }) {
    const outcomeId = params.id
    const id = params.pathId

    if (!id) {
      error({ statusCode: 500, message: 'Oops. Something went wrong.' })
    }

    const path = db.paths.find((p) => p.id === id)

    if (!path) {
      error({ statusCode: 404, message: 'Not found' })
      return
    }

    const resources = lodash.filter(db.resources, (r) =>
      lodash.includes(r.paths, path.id)
    )

    return { outcomeId, path, resources }
  }
}
</script>

<style></style>
