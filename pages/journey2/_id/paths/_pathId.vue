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

      <p class="body-1">
        {{ path.description }}
      </p>
    </div>

    <div class="mt-4 px-3">
      <h2 class="title mt-2 primary--text text--lighten-3">Featured</h2>

      <div v-for="r in featuredResources" :key="r.id" class="mt-3">
        <ResourceCard :resource="r"></ResourceCard>
      </div>
    </div>

    <div class="mt-4 px-3">
      <h2 class="title mt-2 primary--text text--lighten-3">More resources</h2>

      <div class="d-flex justify-start flex-wrap mt-2">
        <v-chip
          v-for="t in tags"
          :key="t"
          class="mr-2 mb-2"
          filter
          :close="t == selectedTag"
          :input-value="t === selectedTag"
          @click="selectedTag = t"
          @click:close="selectedTag = null"
        >
          {{ t }}
        </v-chip>
      </div>

      <div v-for="r in filteredOtherResources" :key="r.id" class="mt-3">
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

    const tags = lodash
      .uniq(lodash.flatten(lodash.map(otherResources, 'tags')))
      .sort()

    return { outcomeId, path, featuredResources, otherResources, tags }
  },
  data() {
    return {
      selectedTag: null
    }
  },
  computed: {
    filteredOtherResources() {
      if (this.selectedTag) {
        return lodash.filter(this.otherResources, (r) =>
          lodash.includes(r.tags, this.selectedTag)
        )
      }
      return this.otherResources
    }
  }
}
</script>

<style></style>
