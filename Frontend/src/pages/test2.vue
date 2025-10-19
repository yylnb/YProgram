<template>
    <div>
        <button @click="test2()">
            click me2
        </button>
    </div>
</template>

<script>
function test2() {
    alert("test2");
}
export default {
    setup() {
        return {
            test2
        }
    }
}
</script>