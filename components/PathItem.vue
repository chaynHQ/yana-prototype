<template>
  <v-btn outlined color="primary" block>{{ path.title }}</v-btn>
</template>

<script>
export default {
  props: {
    path: {
      type: Object,
      required: true
    }
  }
}
</script>

<style></style>
