<template>
  <v-dialog v-model="show" persistent scrollable max-width="400px">
    <v-card>
      <v-card-title class="d-flex flex-column align-end">
        <v-btn v-on:click.stop="done()" color="primary">Done</v-btn>
      </v-card-title>
      <v-divider></v-divider>
      <v-card-text style="height: 500px;">
        <v-form>
          <v-text-field label="Email"></v-text-field>
          <v-text-field label="Password"></v-text-field>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    entry: {
      type: Object,
      required: false,
      default: null
    }
  },
  data() {
    return {}
  },
  computed: {
    show() {
      return !!this.entry
    }
  },
  methods: {
    done() {
      this.$emit('done')
    }
  }
}
</script>

<style></style>
