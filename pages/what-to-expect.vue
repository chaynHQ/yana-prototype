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
          v-for="l in checklists"
          :key="l.name"
          class="checklist"
        >
          <v-expansion-panel-header class="font-weight-bold">
            <v-btn
              class="mr-4"
              fab
              dark
              small
              color="primary"
              elevation="0"
              style="flex: none"
            >
              <v-icon dark>mdi-{{ l.icon }}</v-icon>
            </v-btn>
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
          id: 'victim-support',
          name: 'Victim support',
          icon: 'account-group'
        },
        {
          id: 'reporting',
          name: 'Reporting',
          icon: 'file-document'
        },
        {
          id: 'police-investigation',
          name: 'Police Investigation',
          icon: 'shield-star'
        },
        {
          id: 'prosecution',
          name: 'Prosecution',
          icon: 'gavel'
        },
        {
          id: 'trial',
          name: 'Trial',
          icon: 'gavel'
        },
        {
          id: 'post-trial',
          name: 'Post-trial',
          icon: 'gavel'
        }
      ]
    }
  }
}
</script>
