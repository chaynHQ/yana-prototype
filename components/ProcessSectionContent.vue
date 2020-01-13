<template>
  <div>
    <div v-if="section.processMap && section.processMap.length">
      <h3 class="subtitle-2 font-weight-bold mb-2 text-center">
        Process
      </h3>

      <v-expansion-panels accordion>
        <v-expansion-panel
          v-for="(step, index) in section.processMap"
          :key="index"
          class="process-section-step"
        >
          <v-expansion-panel-header class="pa-3 subtitle-2">
            {{ step.name }}
          </v-expansion-panel-header>
          <v-expansion-panel-content>
            <vue-simple-markdown
              :source="step.text"
              class="body-2"
            ></vue-simple-markdown>
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </div>

    <div v-if="section.resources && section.resources.length" class="mt-4">
      <h3 class="subtitle-2 font-weight-bold mb-2 text-center">
        Resources
      </h3>

      <v-list dense>
        <template v-for="(resource, index) in section.resources">
          <v-list-item :key="resource.name">
            <v-list-item-content>
              <v-list-item-title>
                <a :href="resource.url">{{ resource.name }}</a>
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>

          <v-divider
            v-if="index + 1 < section.resources.length"
            :key="index"
          ></v-divider>
        </template>
      </v-list>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    section: {
      type: Object,
      required: true
    }
  }
}
</script>

<style></style>
