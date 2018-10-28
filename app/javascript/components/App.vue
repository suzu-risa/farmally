<template>
  <div id="app">
    <new-article-list />
  </div>
</template>

<script>
  import NewArticleList from './NewArticleList'

  export default {
    name: 'app',
    components: {
      NewArticleList
    }
  }
</script>

<style lang="sass" scoped>
  #app
    font-family: inherit
    -webkit-font-smoothing: antialiased
    -moz-osx-font-smoothing: grayscale
    text-align: center
</style>
