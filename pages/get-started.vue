<template>
  <section id="get-started">
    <div class="px-3">
      <h1 class="headline">Your case</h1>

      <p class="body-2 mt-3">
        Using the following buttons you can make a record of the assault, access
        support and learn more about what to expect should you decide to report
        to the police.
      </p>
    </div>

    <v-card to="/what-happened" nuxt>
      <v-card-title primary-title>
        <span>What happened?</span>
        <v-spacer></v-spacer>
        <v-icon>
          mdi-chevron-right
        </v-icon>
      </v-card-title>
      <v-card-text>
        A safe space for you to log anything you remember around your assault
        and create a timeline, which can help build your case if you decide to
        report.
      </v-card-text>
    </v-card>

    <v-card class="mt-3" to="/what-to-expect" nuxt>
      <v-card-title primary-title>
        <span>What to expect</span>
        <v-spacer></v-spacer>
        <v-icon>
          mdi-chevron-right
        </v-icon>
      </v-card-title>
      <v-card-text>
        See the processes involved in reporting to the police and how long it
        takes.
      </v-card-text>
    </v-card>

    <v-card class="mt-3">
      <v-card-title primary-title>
        <span>Get support</span>
        <v-spacer></v-spacer>
        <v-icon>
          mdi-chevron-right
        </v-icon>
      </v-card-title>
      <v-card-text>
        Find a directory of support organisations and resources that can help
        you.
      </v-card-text>
    </v-card>
  </section>
</template>

<script>
export default {}
</script>
