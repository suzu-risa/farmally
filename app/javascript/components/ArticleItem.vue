<template>
  <div class="article column is-4-tablet is-4-desktop">
    <div class="article-column-content">
      <div v-if="article.image" class="thumbnail" :style="{ backgroundImage: `url(${article.image})` }" />
      <div v-else class="thumbnail" />
      <div class="content">
        <a :href="article.link">
          <h3 class="title">{{article.title}}</h3>
        </a>
        <p class="description">{{`${article.description.substr(0, 100)}...`}}</p>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'ArticleItem',
    props: {
      article: {
        type: Object,
        required: true,
        default: {}
      }
    }
  }
</script>
