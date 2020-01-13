<template>
  <section id="what-to-expect">
    <div class="px-3">
      <h1 class="headline">What to expect</h1>

      <p class="body-2 mt-3">
        Dealing with authorities regarding your assault can be daunting
        especially if you don’t know what to expect. We’ve simplified this
        information so you know the procedures they need to follow when dealing
        with an assault and a rough idea of how long each step takes. You can
        also spot if there is a miscarriage of justice.
      </p>
    </div>

    <div class="mt-6">
      <v-expansion-panels>
        <v-expansion-panel
          v-for="section in sections"
          :key="section.name"
          class="process-section"
        >
          <v-expansion-panel-header class="font-weight-bold px-3">
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

import ProcessSectionContent from '@/components/ProcessSectionContent'

export default {
  components: { ProcessSectionContent },
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
  }
}
</script>
