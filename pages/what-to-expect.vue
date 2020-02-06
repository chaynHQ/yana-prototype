<template>
  <section id="what-to-expect">
    <back-button :to="'/begin'" :text="'Your case'"></back-button>

    <div class="px-3">
      <h1 class="headline">What to expect</h1>

      <p class="body-2 mt-3">
        Dealing with authorities can be daunting and isolating. We’ve simplified
        information on processes. You can get familiar with what procedures they
        need to follow and a rough idea of how long it should take. You can also
        spot if something hasn’t been handled the way it should.
      </p>
    </div>

    <div class="mt-6">
      <v-expansion-panels>
        <v-expansion-panel
          v-for="section in sections"
          :key="section.name"
          class="process-section"
        >
          <v-expansion-panel-header
            class="font-weight-bold px-3"
            @click="scrollToTarget"
          >
            <v-btn
              class="mr-4"
              fab
              dark
              small
              color="primary"
              elevation="0"
              style="flex: none"
            >
              <v-icon dark>mdi-{{ icons[section.name] || defaultIcon }}</v-icon>
            </v-btn>
            {{ section.name }}
          </v-expansion-panel-header>
          <v-expansion-panel-content>
            <process-section-content
              :section="section"
            ></process-section-content>
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </div>
  </section>
</template>

<script>
import processSections from '@/data/process-sections.json'

import BackButton from '@/components/BackButton'
import ProcessSectionContent from '@/components/ProcessSectionContent'

export default {
  components: { BackButton, ProcessSectionContent },
  data() {
    return {
      sections: processSections.sections,
      defaultIcon: 'ballot',
      icons: {
        'Reporting to the police': 'file-document',
        'Medical examination': 'medical-bag',
        'Police Investigation': 'shield-star',
        'Decision to prosecute': 'gavel'
      }
    }
  },
  mounted() {
    console.log(`processSections.dateLastActivity = ${processSections.dateLastActivity}`); // eslint-disable-line
  },
  methods: {
    scrollToTarget(event) {
      if (event) {
        setTimeout(() => this.$vuetify.goTo(event.target), 350)
      }
    }
  }
}
</script>
