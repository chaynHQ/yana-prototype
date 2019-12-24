<template>
  <section id="what-to-expect">
    <div class="px-3">
      <h1 class="headline">What to expect</h1>

      <p class="body-2 mt-3">
        Here you will find all the procedures these institutions need to follow,
        and how long each step will take.
      </p>
    </div>

    <div class="mt-6">
      <v-expansion-panels>
        <v-expansion-panel
          v-for="l in checklists"
          :key="l.name"
          class="checklist"
        >
          <v-expansion-panel-header class="font-weight-bold">
            {{ l.name }}
          </v-expansion-panel-header>
          <v-expansion-panel-content>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
            eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim
            ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
            aliquip ex ea commodo consequat.
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </div>
  </section>
</template>

<script>
export default {
  data() {
    return {
      checklists: [
        {
          name: 'Reporting',
          image: 'reporting'
        },
        {
          name: 'Police Investigation',
          image: 'police-investigation'
        },
        {
          name: 'Prosecution',
          image: 'prosecution'
        },
        {
          name: 'Trial',
          image: 'trial'
        },
        {
          name: 'Post-trial',
          image: 'post-trial'
        },
        {
          name: 'Long-term victim support',
          image: 'long-term-victim-support'
        }
      ]
    }
  }
}
</script>
