<template>
  <section id="landing">
    <div class="px-3">
      <p
        class="body-1 text-center font-weight-bold accent--text text--darken-3"
      >
        Built with survivors for survivors.
        <br />
        You are not alone.
      </p>

      <v-img src="/Yana-illustrations-08.png" height="100" contain></v-img>

      <p class="mt-4 mb-1 body-1 font-weight-bold">
        If you’ve been treated in a way that has made you feel uncomfortable or
        violated, use yana to find out how to get support and report the
        assault. Let yana be your companion because you’re not alone.
      </p>
      <p class="body-2">
        Data will be stored on this device only. We respect your privacy.
      </p>
    </div>

    <div class="mt-4 px-3">
      <p class="body-2">
        In an emergency
        <span class="text-uppercase font-weight-bold primary--text">
          DIAL 999
        </span>
      </p>
    </div>

    <div class="mt-6 d-flex justify-center">
      <v-btn class="px-8" color="primary" large to="/begin" nuxt>
        Begin
      </v-btn>
    </div>

    <div class="mt-10 d-flex justify-center">
      <v-btn class="px-8" color="primary" large to="/journey" nuxt>
        Journey
      </v-btn>
    </div>
  </section>
</template>

<script>
export default {
  head() {
    return {
      bodyAttrs: {
        class: 'page-landing'
      }
    }
  }
}
</script>
