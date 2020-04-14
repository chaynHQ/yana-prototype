<template>
  <v-btn outlined color="primary" block @click="select">{{ path.title }}</v-btn>
</template>

<script>
export default {
  props: {
    path: {
      type: Object,
      required: true
    }
  },
  methods: {
    select() {
      this.$emit('select', this.path)
    }
  }
}
</script>

<style></style>
