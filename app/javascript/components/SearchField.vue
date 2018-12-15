<!-- TOPページのリニューアルで一旦このファイルは不要かもしれないが、仕様が固まっていないので残します。不要だと判断したら削除してください -->

<template>
  <div id="navMenu" class="navbar-menu">
    <form class="field is-horizontal has-text-centered search-box">
      <div class="control">
        <span class="select-type">カテゴリー</span>
        <div class="select">
          <select name="category" v-model="currentCategoryId" v-on:change="change">
            <option :value="0">全て</option>
            <option v-for="category in masterCategories" :key="category.id" :value="category.id">{{category.name}}</option>
          </select>
        </div>
      </div>
      <div v-if="currentCategoryId > 0" class="control">
        <span class="select-type">サブカテゴリー</span>
        <div class="select">
          <select name="sub_category" v-model="currentSubCategoryCode">
            <option value="">全て</option>
            <option v-for="category in masterSubCategories[currentCategoryId]" :key="category.code" :value="category.code">{{category.name}}</option>
          </select>
        </div>
      </div>
      <div class="control">
      <span class="select-type">メーカー</span>
        <div class="select">
          <select name="maker" v-model="currentMakerCode">
            <option value="">全て</option>
            <option v-for="maker in masterMakers" :key="maker.code" :value="maker.code">{{maker.name}}</option>
          </select>
        </div>
      </div>
      <a class="control button is-primary" :href="link"><img src="../assets/search.png" alt="検索する"></a>
    </form>
  </div>
</template>

<script>
  export default {
    name: 'search',
    data() {
      return {
        currentCategoryId: 0,
        currentSubCategoryCode: '',
        currentMakerCode: '',
        masterCategories: [],
        masterSubCategories: [],
        masterMakers: []
      }
    },
    created() {
      const masterCategories = JSON.parse(document.getElementById('category-master-data').value)
      const masterSubCategories = JSON.parse(document.getElementById('sub-category-master-data').value)
      const masterMakers = JSON.parse(document.getElementById('maker-master-data').value)
      this.$set(this, 'masterCategories', masterCategories)
      this.$set(this, 'masterSubCategories', masterSubCategories)
      this.$set(this, 'masterMakers', masterMakers)
    },
    computed: {
      link() {
        const category = this.currentCategoryId > 0 ? this.masterCategories.filter(c => c.id === this.currentCategoryId)[0].code : ''
        const subCategory = this.currentSubCategoryCode
        const maker = this.currentMakerCode
        const active = []
        if (category) active.push({ key: 'category', value: category })
        if (subCategory) active.push({ key: 'sub_category', value: subCategory })
        if (maker) active.push({ key: 'maker', value: maker })
        return active.length > 0 ? `/search?${active.map(a => `${a.key}=${a.value}`).join('&')}` : '/search'
      }
    },
    methods: {
      change(e) {
        this.$set(this, 'currentSubCategoryCode', '')
      }
    }
  }
</script>
