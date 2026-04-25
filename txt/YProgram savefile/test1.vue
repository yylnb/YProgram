<template>
    <div>
        <button @click="test1()">
            click me1
        </button>
    </div>
    <br>
    <div style="background-color: red; height: 100px;">
        test
    </div>
    <br>
    <Test2 />
</template>

<script>

import Test2 from './test2.vue'

export default {
    components: {
        Test2
    },
    setup() {
        return {
            test1
        }
    }
}

function test1() {
    alert("test1");
}

</script>