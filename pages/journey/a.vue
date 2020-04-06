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

    <div class="mt-6">
      <div v-if="!selected">
        <v-card tile>
          <v-list>
            <template v-for="(p, index) in phases">
              <v-list-item :key="p.id" @click="selectPhase(p)">
                <v-list-item-icon>
                  <v-btn
                    class="mr-4"
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
                  <v-list-item-title v-text="p.title"></v-list-item-title>
                </v-list-item-content>
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
          <v-tabs v-model="tab" grow show-arrows>
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
                <v-card-text>Questions</v-card-text>
              </v-card>
            </v-tab-item>

            <v-tab-item key="process">
              <v-card flat>
                <v-card-text>Process</v-card-text>
              </v-card>
            </v-tab-item>

            <v-tab-item key="resources">
              <v-card flat>
                <v-card-text>Resources</v-card-text>
              </v-card>
            </v-tab-item>

            <v-tab-item key="checklist">
              <v-card flat>
                <v-card-text>Checklist</v-card-text>
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
    }
  }
}
</script>
