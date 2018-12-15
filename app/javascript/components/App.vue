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
