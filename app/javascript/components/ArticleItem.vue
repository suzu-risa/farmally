<template>
  <li class="article">
    <div v-if="article.image" class="thumbnail" :style="{ backgroundImage: `url(${article.image})` }" />
    <div v-else class="thumbnail" />
    <div class="content">
      <a :href="article.link" class="title">
        <h3>{{article.title}}</h3>
      </a>
      <p class="description">{{`${article.description.substr(0, 100)}...`}}</p>
    </div>
  </li>
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

<style lang="sass" scoped>
  .article
    list-style-type: none
    display: flex
    flex-direction: row
    background-color: #f4f2f1
    text-align: left

    @media screen and (max-width: 768px)
      flex-direction: column

    .thumbnail
      background-color: lightgray
      background-repeat: no-repeat
      background-position: center
      background-size: cover
      width: 100%
      height: 200px

      @media screen and (min-width: 769px)
        width: 240px
        height: 144px

    .content
      padding: 15px
      flex: 1
      height: 200px;
      overflow-y: hidden;

      @media screen and (min-width: 769px)
        height: 144px

      .title
        color: #616161
        h3
          color: #616161
          font-size: 24px
          max-height: 54px
          overflow: hidden
        &:hover
          text-decoration: underline
</style>
