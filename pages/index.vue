<template>
  <section id="landing">
    <div class="mt-4 px-3">
      <p class="title font-weight-bold">
        If you’ve been touched or treated in a way that has made you feel
        uncomfortable or violated, use this site to find out how to get to
        safety, get help and report the sexual assault.
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
        This has been co-designed with survivors of sexual assault. We will
        respect your privacy.
      </p>
    </div>

    <div class="mt-12 px-3">
      <p class="body-2">
        If you are in an emergency situation
        <span class="text-uppercase font-weight-bold primary--text">
          DIAL 999
        </span>
      </p>
      <p class="body-2">
        If you need help taking care of yourself have a look at these
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
