<template>
  <v-app>
    <v-navigation-drawer v-model="drawer" fixed app>
      <v-list>
        <v-list-item
          v-for="(item, i) in items"
          :key="i"
          :to="item.to"
          router
          exact
        >
          <v-list-item-action>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title v-text="item.title" />
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <v-app-bar
      fixed
      flat
      app
      hide-on-scroll
      color="rgba(255,255,255,0.5)"
      height="72px"
    >
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      <v-toolbar-title v-text="title" />
    </v-app-bar>

    <v-content>
      <v-container class="px-3 py-5">
        <message-bar></message-bar>
        <nuxt />
      </v-container>
    </v-content>

    <app-footer></app-footer>
  </v-app>
</template>

<script>
import MessageBar from '@/components/MessageBar'
import AppFooter from '@/components/AppFooter'

export default {
  components: { MessageBar, AppFooter },
  data() {
    return {
      drawer: false,
      items: [
        {
          icon: 'mdi-apps',
          title: 'Home',
          to: '/'
        },
        {
          icon: 'mdi-information',
          title: 'About',
          to: '/about'
        },
        {
          icon: 'mdi-account-multiple',
          title: 'Partners',
          to: '/partners'
        },
        {
          icon: 'mdi-update',
          title: 'Updates',
          to: '/updates'
        }
      ],
      title: 'YANA'
    }
  }
}
</script>

<style>
.v-app-bar.theme--light.v-sheet {
  border-bottom: 1px solid #d3486a !important;
}
</style>
