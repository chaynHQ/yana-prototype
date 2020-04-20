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

    <div class="mt-4 px-3">
      <h2 class="title mt-2 primary--text text--lighten-3">Featured</h2>

      <div v-for="r in featuredResources" :key="r.id" class="mt-3">
        <ResourceCard :resource="r"></ResourceCard>
      </div>
    </div>

    <div class="mt-4 px-3">
      <h2 class="title mt-2 primary--text text--lighten-3">Other</h2>

      <div v-for="r in otherResources" :key="r.id" class="mt-3">
        <ResourceCard :resource="r"></ResourceCard>
      </div>
    </div>
  </section>
</template>

<script>
import lodash from 'lodash'
import db from '@/data/journey2.json'

import ResourceCard from '@/components/ResourceCard'

export default {
  components: { ResourceCard },
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

    const [featuredResources, otherResources] = lodash.partition(
      resources,
      (r) => r.featured
    )

    return { outcomeId, path, featuredResources, otherResources }
  }
}
</script>

<style></style>
