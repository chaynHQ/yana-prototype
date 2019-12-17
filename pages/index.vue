<template>
  <section id="landing">
    <div id="landing-header">
      <!-- <v-container> -->
      <v-row justify="space-between" class="px-3">
        <v-col md="4" class="py-0">
          <v-tooltip
            attach="#landing-header"
            bottom
            color="white grey--text darken-2--text"
            content-class="info-tooltip"
          >
            <template v-slot:activator="{ on }">
              <v-icon v-on="on" size="24px" color="primary">
                mdi-alert-circle-outline
              </v-icon>
            </template>
            <span>
              Lorem ipsum dolor sit amet, consectetur elit, sed do eiusmod
              tempor incididunt labore et dolore magna aliqua adipisicing.
            </span>
          </v-tooltip>
        </v-col>
        <v-col md="4" class="py-0 text-right">
          <a href="#" class="text-uppercase" color="primary">
            Leave this site
          </a>
        </v-col>
      </v-row>
      <!-- </v-container> -->
    </div>

    <div class="mt-10 px-3">
      <p class="title font-weight-bold">
        If you've been touched in a way that has made you feel uncomfortable or
        violated, use this site to find out how to get to safety, feel better
        and report the assault.
      </p>

      <v-btn
        class="mt-10 text-uppercase"
        color="primary"
        large
        block
        to="/get-started"
        nuxt
      >
        Get started
      </v-btn>

      <p class="mt-4 body-2">
        Context text lorem ipsum sit dolor amet
      </p>
    </div>

    <div class="mt-12 px-3">
      <p class="body-2">
        If you are in an emergency situation
        <br />
        <span class="text-uppercase font-weight-bold primary--text">
          DIAL 999
        </span>
      </p>
      <p class="body-2">
        Context text…
        <span class="text-uppercase font-weight-bold primary--text">
          First aid steps
        </span>
      </p>
    </div>
  </section>
</template>

<script>
export default {}
</script>
