<template>
  <div>
    <div v-if="section.processMap && section.processMap.length">
      <h3 class="subtitle-2 font-weight-bold mb-1 text-center">
        <v-chip label color="pink lighten-5" text-color="primary">
          Process
        </v-chip>
      </h3>

      <v-expansion-panels accordion class="process-section-steps">
        <v-expansion-panel
          v-for="(step, index) in section.processMap"
          :key="index"
          class="process-section-step"
        >
          <v-expansion-panel-header
            class="subtitle-2"
            color="transparent"
            @click="scrollToTarget"
          >
            <div class="process-section-step-header">
              {{ step.name }}
            </div>
          </v-expansion-panel-header>
          <v-expansion-panel-content color="transparent">
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

    <div v-if="section.resources && section.resources.length" class="mt-4">
      <h3 class="subtitle-2 font-weight-bold mb-1 text-center">
        <v-chip label color="pink lighten-5" text-color="primary">
          Resources
        </v-chip>
      </h3>

      <p class="body-2 px-3 mt-4">
        We’ve tried to break all of the necessary information down into more
        manageable chunks above, however if you’d like to read more in depth
        then you can take a look at these resources.
      </p>

      <ul class="simple-list body-2">
        <li v-for="(resource, index) in section.resources" :key="index">
          <a :href="resource.url">{{ resource.name }}</a>
        </li>
      </ul>
    </div>

    <div v-if="section.checklist && section.checklist.length" class="mt-4">
      <h3 class="subtitle-2 font-weight-bold mb-1 text-center">
        <v-chip label color="pink lighten-5" text-color="primary">
          Checklist
        </v-chip>
      </h3>

      <p class="body-2 px-3 mt-4">
        It can be hard to know whether things are progressing as they should. To
        help you be more in control, we’ve created this checklist. Mark events
        that have taken place and raise with the relevant parties if you feel
        any steps were missed.
      </p>

      <ul class="simple-list checklist body-2">
        <li v-for="(item, index) in section.checklist" :key="index">
          <v-checkbox
            v-model="item.done"
            :label="item.text"
            hide-details
            :ripple="false"
          ></v-checkbox>
        </li>
      </ul>
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
  },
  methods: {
    scrollToTarget(event) {
      if (event) {
        setTimeout(() => this.$vuetify.goTo(event.target), 300)
      }
    }
  }
}
</script>

<style></style>
