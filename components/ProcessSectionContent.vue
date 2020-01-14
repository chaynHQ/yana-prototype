<template>
  <div>
    <div v-if="section.processMap && section.processMap.length">
      <h3 class="subtitle-2 font-weight-bold mb-2 text-center">
        <v-chip label color="pink lighten-5">
          Process
        </v-chip>
      </h3>

      <v-expansion-panels accordion class="process-section-steps">
        <v-expansion-panel
          v-for="(step, index) in section.processMap"
          :key="index"
          class="process-section-step"
        >
          <v-expansion-panel-header class="subtitle-2" color="pink lighten-5">
            <div class="process-section-step-header">
              {{ step.name }}
            </div>
          </v-expansion-panel-header>
          <v-expansion-panel-content color="pink lighten-5">
            <div class="process-section-step-content">
              <vue-simple-markdown
                :source="step.text"
                class="body-2"
              ></vue-simple-markdown>
            </div>
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </div>

    <div v-if="section.resources && section.resources.length" class="mt-5">
      <h3 class="subtitle-2 font-weight-bold mb-2 text-center">
        <v-chip label color="indigo lighten-5">
          Resources
        </v-chip>
      </h3>

      <v-list dense color="indigo lighten-5">
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

    <div v-if="section.checklist && section.checklist.length" class="mt-5">
      <h3 class="subtitle-2 font-weight-bold mb-2 text-center">
        <v-chip label color="green lighten-5">
          Checklist
        </v-chip>
      </h3>

      <v-list dense color="green lighten-5">
        <template v-for="(item, index) in section.checklist">
          <v-list-item :key="item.text">
            <v-list-item-action>
              <v-checkbox v-model="item.done" color="primary"></v-checkbox>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>
                {{ item.text }}
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>

          <v-divider
            v-if="index + 1 < section.checklist.length"
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
