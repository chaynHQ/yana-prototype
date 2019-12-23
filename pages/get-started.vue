<template>
  <section id="get-started">
    <div class="px-3">
      <h1 class="headline">Get Started</h1>

      <p class="body-2 mt-3">
        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna wirl aliqua. Ut enim ad
        minim ikad veniam, quis nostrud exercitatn ullamco laboris aliquip.
      </p>
    </div>

    <v-card to="/what-happened" nuxt>
      <v-card-title>
        <span>What happened?</span>
        <v-spacer></v-spacer>
        <v-icon>
          mdi-chevron-right
        </v-icon>
      </v-card-title>
      <v-card-text>
        Secondary line text lorem ipsum dapibus, neque id cursus faucibus
      </v-card-text>
    </v-card>

    <v-card class="mt-3" to="/what-to-expect" nuxt>
      <v-card-title>
        <span>What to expect</span>
        <v-spacer></v-spacer>
        <v-icon>
          mdi-chevron-right
        </v-icon>
      </v-card-title>
      <v-card-text>
        Secondary line text lorem ipsum dapibus, neque id cursus faucibus
      </v-card-text>
    </v-card>
  </section>
</template>

<script>
export default {}
</script>
