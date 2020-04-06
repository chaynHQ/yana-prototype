<template>
  <section id="journey-a">
    <div v-if="!selected" class="px-3">
      <h1 class="headline">Your Journey</h1>
    </div>
    <div v-else>
      <v-btn text @click="back">
        <v-icon left>mdi-arrow-left</v-icon>
        Back
      </v-btn>
    </div>

    <div class="mt-4">
      <div v-if="!selected">
        <v-card>
          <v-list class="pa-0">
            <template v-for="(p, index) in phases">
              <v-list-item :key="p.id" @click="selectPhase(p)">
                <v-list-item-icon class="mr-4">
                  <v-btn
                    fab
                    dark
                    small
                    color="primary"
                    elevation="0"
                    style="flex: none"
                  >
                    <v-icon dark>mdi-ballot</v-icon>
                  </v-btn>
                </v-list-item-icon>

                <v-list-item-content>
                  <v-list-item-title
                    class="font-weight-bold"
                    v-text="p.title"
                  ></v-list-item-title>
                </v-list-item-content>

                <v-list-item-action>
                  <v-icon color="grey lighten-1">
                    mdi-heart-outline
                  </v-icon>
                </v-list-item-action>
              </v-list-item>

              <v-divider
                v-if="index + 1 < phases.length"
                :key="index"
              ></v-divider>
            </template>
          </v-list>
        </v-card>
      </div>

      <div v-else>
        <v-card>
          <v-tabs
            v-model="tab"
            grow
            show-arrows
            background-color="primary"
            dark
          >
            <v-tab key="questions">
              Questions
            </v-tab>

            <v-tab key="process">
              Process
            </v-tab>

            <v-tab key="resources">
              Resources
            </v-tab>

            <v-tab key="checklist">
              Checklist
            </v-tab>
          </v-tabs>

          <v-tabs-items v-model="tab">
            <v-tab-item key="questions">
              <v-card flat>
                <v-card-text>
                  <ul class="simple-list body-2">
                    <li
                      v-for="(question, index) in selected.questions"
                      :key="index"
                    >
                      {{ question.title }}
                    </li>
                  </ul>
                </v-card-text>
              </v-card>
            </v-tab-item>

            <v-tab-item key="process">
              <v-card flat class="process-section">
                <v-card-text>
                  <v-expansion-panels accordion class="process-section-steps">
                    <v-expansion-panel
                      v-for="(step, index) in selected.process"
                      :key="index"
                      class="process-section-step"
                      style="background-color: white"
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
                </v-card-text>
              </v-card>
            </v-tab-item>

            <v-tab-item key="resources">
              <v-card flat>
                <v-card-text>
                  <p class="body-2 px-3 mt-2">
                    We’ve tried to break all of the necessary information down
                    into more manageable chunks above, however if you’d like to
                    read more in depth then you can take a look at these
                    resources.
                  </p>

                  <ul class="simple-list body-2">
                    <li
                      v-for="(resource, index) in selected.resources"
                      :key="index"
                    >
                      <a :href="resource.url" target="_blank" rel="noopener">
                        {{ resource.name }}
                      </a>
                    </li>
                  </ul>
                </v-card-text>
              </v-card>
            </v-tab-item>

            <v-tab-item key="checklist">
              <v-card flat>
                <v-card-text>
                  <p class="body-2 px-3 mt-4">
                    It can be hard to know whether things are progressing as
                    they should. To help you be more in control, we’ve created
                    this checklist. Mark events that have taken place and raise
                    with the relevant parties if you feel any steps were missed.
                  </p>

                  <ul class="simple-list checklist body-2">
                    <li
                      v-for="(item, index) in selected.checklist"
                      :key="index"
                    >
                      <v-checkbox
                        v-model="item.done"
                        :label="item.text"
                        hide-details
                        :ripple="false"
                      ></v-checkbox>
                    </li>
                  </ul>

                  <div class="mt-3 d-flex justify-center">
                    <v-btn color="primary" small>
                      <v-icon left>mdi-pdf-box</v-icon>
                      Download checklist
                    </v-btn>
                  </div>
                </v-card-text>
              </v-card>
            </v-tab-item>
          </v-tabs-items>
        </v-card>
      </div>
    </div>
  </section>
</template>

<script>
import processSections from '@/data/process-sections.json'
import journey from '@/data/journey.json'

export default {
  asyncData() {
    const dummySection = processSections.sections[0]
    const phases = journey.phases.map((p) => {
      return {
        id: p.id,
        title: p.title,
        questions: journey.questions,
        process: dummySection.processMap,
        resources: dummySection.resources,
        checklist: dummySection.checklist
      }
    })

    return { phases }
  },
  data() {
    return {
      tab: null,
      selected: null
    }
  },
  methods: {
    back() {
      this.tab = null
      this.selected = null
    },
    selectPhase(p) {
      this.selected = p
    },
    scrollToTarget(event) {
      if (event) {
        setTimeout(() => this.$vuetify.goTo(event.target), 350)
      }
    }
  }
}
</script>
