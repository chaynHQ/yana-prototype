<template>
  <div class="back-button">
    <nuxt-link :to="to">
      <v-icon left>mdi-arrow-left</v-icon>
      back to {{ text }}
    </nuxt-link>
  </div>
</template>

<script>
export default {
  props: {
    to: {
      type: String,
      required: true
    },
    text: {
      type: String,
      required: true
    }
  }
}
</script>

<style lang="scss" scoped>
.back-button {
  margin-top: -10px;
  margin-bottom: 20px;

  a {
    text-decoration: none;
    color: rgba($text-color, 0.75);
  }
}
</style>
