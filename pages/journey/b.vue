<template>
  <section id="journey-b">
    <div v-if="!selected" class="px-3">
      <h1 class="headline">Your Journey [option B]</h1>
    </div>
    <div v-else>
      <v-btn text @click="back">
        <v-icon left>mdi-arrow-left</v-icon>
        Back
      </v-btn>
    </div>

    <div class="mt-4">
      <div v-if="!selected">
        <p class="body-1">What outcome(s) do you want to focus on?</p>

        <ul class="simple-list checklist body-1">
          <li v-for="(item, index) in outcomes" :key="index">
            <v-checkbox :label="item" hide-details :ripple="false"></v-checkbox>
          </li>
        </ul>

        <p class="body-2 mt-2 px-3">
          <em>You can come back and change your preferences at any time.</em>
        </p>

        <div class="mt-4 d-flex justify-center">
          <v-btn color="primary" @click="next">
            Next
            <v-icon right>mdi-arrow-right</v-icon>
          </v-btn>
        </div>
      </div>

      <div v-else>
        <p class="body-1 px-3">
          We've selected some resources for you.
        </p>
        <p class="body-2 px-3">
          You can take your time and come back to this whenever you want.
        </p>

        <div class="mt-2">
          <v-card v-for="(r, index) in resources" :key="index" class="mb-3">
            <v-card-text>
              <div v-if="r.type == 'question'">
                <div class="mb-3 d-flex justify-space-between">
                  <v-chip small color="pink lighten-5" class="font-weight-bold">
                    {{ r.phase }}
                  </v-chip>
                  <v-chip small color="pink" outlined class="font-weight-bold">
                    Q&A
                  </v-chip>
                </div>
                <h3 class="title">{{ r.title }}</h3>
                <p class="body-2 mt-2">
                  Lorem ipsum dolor sit amet consectetur adipisicing elit.
                  Ducimus voluptates vitae cum fugit suscipit reiciendis illum
                  id adipisci quae fuga reprehenderit, aut totam vero non quod
                  iste ipsam. Nulla, sed!
                </p>
              </div>
              <div v-else-if="r.type == 'resource'">
                <div class="mb-3 d-flex justify-space-between">
                  <v-chip small color="pink lighten-5" class="font-weight-bold">
                    {{ r.phase }}
                  </v-chip>
                  <v-chip small color="pink" outlined class="font-weight-bold">
                    Resource
                  </v-chip>
                </div>
                <a :href="r.url" target="_blank" rel="noopener">
                  {{ r.name }}
                </a>
              </div>
              <div
                v-else-if="r.type == 'process'"
                class="process-section"
                style="background: white"
              >
                <div class="mb-3 d-flex justify-space-between">
                  <v-chip small color="pink lighten-5" class="font-weight-bold">
                    {{ r.phase }}
                  </v-chip>
                  <v-chip small color="pink" outlined class="font-weight-bold">
                    Process
                  </v-chip>
                </div>
                <h4 class="title"></h4>
                <v-expansion-panels accordion class="process-section-steps">
                  <v-expansion-panel
                    v-for="(step, index2) in r.process"
                    :key="index2"
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
              </div>
              <div v-else-if="r.type == 'checklist'">
                <div class="mb-3 d-flex justify-space-between">
                  <v-chip small color="pink lighten-5" class="font-weight-bold">
                    {{ r.phase }}
                  </v-chip>
                  <v-chip small color="pink" outlined class="font-weight-bold">
                    Checklist
                  </v-chip>
                </div>
                <ul class="simple-list checklist body-2">
                  <li v-for="(item, index2) in r.checklist" :key="index2">
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
              </div>
            </v-card-text>
          </v-card>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import _ from 'lodash'
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
      outcomes: [
        'Legal conviction',
        'Telling a friend or family',
        'Telling a partner',
        'Moving on with life',
        'Rebuilding trust in systems and people',
        'Mental health recovery',
        'Self-acceptance and love'
      ],
      tab: null,
      selected: null,
      resources: []
    }
  },
  methods: {
    back() {
      this.selected = null
    },
    next() {
      this.selected = true

      const selectedPhases = _.sampleSize(this.phases, 2)
      const items = []

      selectedPhases.forEach((p) => {
        p.questions.forEach((q) => {
          items.push({
            type: 'question',
            phase: p.title,
            ...q
          })
        })

        p.resources.forEach((r) => {
          items.push({
            type: 'resource',
            phase: p.title,
            ...r
          })
        })

        items.push({ type: 'process', phase: p.title, process: p.process })

        items.push({
          type: 'checklist',
          phase: p.title,
          checklist: p.checklist
        })
      })

      this.resources = _.shuffle(items)
    },
    scrollToTarget(event) {
      if (event) {
        setTimeout(() => this.$vuetify.goTo(event.target), 350)
      }
    }
  }
}
</script>
