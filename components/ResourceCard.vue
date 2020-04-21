<template>
  <v-card outlined class="resource-card">
    <v-list-item v-if="resource.tags.length" dense>
      <v-list-item-content class="overline pa-0">
        {{ resource.tags.join(', ') }}
      </v-list-item-content>
    </v-list-item>

    <v-card-title class="title pt-0 d-flex flex-nowrap">
      <v-icon left>mdi-{{ icons[resource.type] }}</v-icon>
      <span class="d-block tw-truncate">{{ resource.title }}</span>
    </v-card-title>

    <v-card-subtitle
      v-if="resource.subtitle || resource.url"
      class="subtitle-1 mt-0"
    >
      <div v-if="resource.subtitle">{{ resource.subtitle }}</div>

      <div v-if="resource.url">
        <a :href="resource.url" target="_blank" rel="noopener">
          {{ resource.url }}
          <v-icon x-small>mdi-open-in-new</v-icon>
        </a>
      </div>
    </v-card-subtitle>

    <v-card-text v-if="resource.description">
      <div class="body-1">{{ resource.description }}</div>

      <div
        v-if="resource.service === 'Spotify' || resource.service === 'YouTube'"
        class="mt-4"
      >
        <div
          v-if="resource.service === 'Spotify'"
          class="d-flex justify-center"
        >
          <iframe
            class="tw-border"
            :src="resource.embedSrc"
            width="320"
            height="380"
            frameborder="0"
            allowtransparency="true"
            allow="encrypted-media"
          ></iframe>
        </div>

        <div
          v-if="resource.service === 'YouTube'"
          class="d-flex justify-center"
        >
          <iframe
            width="320"
            height="180"
            :src="resource.embedSrc"
            frameborder="0"
            allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
            allowfullscreen
          ></iframe>
        </div>
      </div>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  props: {
    resource: { type: Object, required: true }
  },
  data() {
    return {
      icons: {
        course: 'file-multiple',
        website: 'web',
        audio: 'spotify',
        video: 'youtube',
        'online-book': 'book-open-variant',
        podcast: 'podcast',
        'mini-app': 'apps-box'
      }
    }
  }
}
</script>

<style></style>
