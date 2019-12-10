<template>
  <div>
    <h1>Get Started</h1>

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
  </div>
</template>

<script>
export default {}
</script>
