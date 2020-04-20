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

    <v-card-subtitle v-if="resource.subtitle" class="subtitle-2">
      {{ resource.subtitle }}
    </v-card-subtitle>

    <v-card-text v-if="resource.description">
      <div class="body-2">{{ resource.description }}</div>
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
