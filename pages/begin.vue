<template>
  <section id="begin">
    <back-button :to="'/'" :text="'Home'"></back-button>

    <div class="px-3">
      <h1 class="headline">Your case</h1>

      <p class="body-2 mt-3">
        One-line supportive text.
      </p>
    </div>

    <div class="cards mt-5 pa-6">
      <v-card to="/what-happened" nuxt tile flat color="#FFF5F0">
        <v-card-text>
          <div class="d-flex">
            <div class="flex-grow-1">
              <p class="title mb-1">
                What happened
              </p>
              <div class="body-2">
                Note down what you remember & build a timeline
              </div>
            </div>
            <div>
              <v-img
                src="/Yana-illustrations-08.png"
                width="100"
                contain
                class="ml-1"
              ></v-img>
            </div>
          </div>
        </v-card-text>
      </v-card>

      <v-card class="mt-3" to="/what-to-expect" nuxt tile flat color="#FFF5F0">
        <v-card-text>
          <div class="d-flex">
            <div class="flex-grow-1">
              <p class="title mb-1">
                What to expect
              </p>
              <div class="body-2">
                See the processes involved in reporting your case
              </div>
            </div>
            <div>
              <v-img
                src="/Yana-illustrations-02.png"
                width="100"
                contain
                class="ml-1"
              ></v-img>
            </div>
          </div>
        </v-card-text>
      </v-card>

      <v-card class="mt-3" to="/get-support" nuxt tile flat color="#FFF5F0">
        <v-card-text>
          <div class="d-flex">
            <div class="flex-grow-1">
              <p class="title mb-1">
                Get support
              </p>
              <div class="body-2">
                Find local organisations that can help
              </div>
            </div>
            <div>
              <v-img
                src="/Yana-illustrations-10.png"
                width="100"
                contain
                class="ml-1"
              ></v-img>
            </div>
          </div>
        </v-card-text>
      </v-card>
    </div>
  </section>
</template>

<script>
import BackButton from '@/components/BackButton'

export default {
  components: { BackButton }
}
</script>

<style lang="scss" scoped>
.cards {
  margin-left: -12px;
  margin-right: -12px;
  margin-bottom: -20px;
  background: url('/YANA-background-02.png') no-repeat bottom;
  background-size: cover;

  .v-card {
    border: 5px solid #1d2445 !important;
  }
}
</style>
