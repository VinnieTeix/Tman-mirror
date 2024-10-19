<script setup lang="ts">
import { ref } from 'vue'
import { RouterLink } from 'vue-router'
import InputSwitch from 'primevue/inputswitch'
import Menu from 'primevue/menu'
import Sidebar from 'primevue/sidebar'
import 'primeicons/primeicons.css'
import ToggleButton from 'primevue/togglebutton'
import Dropdown from 'primevue/dropdown'

// Gérer le mode sombre
const isDarkMode = ref(false)
const toggleDarkMode = () => {
  isDarkMode.value = !isDarkMode.value
  document.documentElement.classList.toggle('dark', isDarkMode.value)
}

// Menu pour les langues
const items = [
  { label: 'Français', icon: 'pi pi-globe' },
  { label: 'English', icon: 'pi pi-globe' },
  { label: 'Español', icon: 'pi pi-globe' },
]

// Gérer l'état de la barre latérale (side bar)
const isSidebarVisible = ref(false)
</script>

<template>
  <header
    class="bg-gray-800 p-4 text-white flex justify-between items-center relative"
  >
    <!-- Logo de menu avec icône PrimeVue -->
    <div class="relative">
      <button @click="isSidebarVisible = true" class="text-white p-2">
        <i class="pi pi-bars" style="font-size: 1.5rem"></i>
      </button>
    </div>

    <!-- Barre latérale (Sidebar) pour les pages -->
    <Sidebar v-model:visible="isSidebarVisible" class="p-4" :baseZIndex="1000">
      <h3 class="mb-4 text-lg font-bold">Menu</h3>
      <RouterLink to="/" class="block mb-2">Home</RouterLink>
      <RouterLink to="/about" class="block mb-2">About</RouterLink>
    </Sidebar>

    <!-- Logo au centre -->
    <RouterLink to="/">
      <img
        alt="Vue logo"
        class="h-16 mx-auto"
        src="@/assets/images/GotimeManager.png"
      />
    </RouterLink>

    <!-- Boutons à droite -->
    <div class="flex gap-4 items-center">
      <!-- Switch de mode sombre avec InputSwitch et icône Sun/Moon -->
      <div class="flex items-center">
        <i
          :class="isDarkMode ? 'pi pi-moon' : 'pi pi-sun'"
          style="font-size: 1.5rem; margin-right: 0.5rem"
        ></i>
        <InputSwitch v-model="isDarkMode" @change="toggleDarkMode" />
      </div>

      <!-- Menu déroulant pour les langues avec PrimeVue -->
      <Menu :model="items">
        <template #trigger>
          <button
            class="bg-gray-600 hover:bg-gray-500 text-white px-4 py-2 rounded-md"
          >
            <i class="pi pi-globe" style="margin-right: 0.5rem"></i> Langue
          </button>
        </template>
      </Menu>

      <Dropdown
        v-model="selectedLanguage"
        :options="items"
        optionLabel="label"
        optionValue="label"
        class="w-full md:w-14rem"
      >
        <template #value>
          <button
            class="bg-gray-600 hover:bg-gray-500 text-white px-4 py-2 rounded-md"
          >
            <i class="pi pi-globe" style="margin-right: 0.5rem"></i>
            {{ selectedLanguage || 'Langue' }}
          </button>
        </template>
      </Dropdown>

      <!-- Bouton de connexion -->
      <button
        class="bg-blue-600 hover:bg-blue-500 text-white px-4 py-2 rounded-md"
      >
        Connect
      </button>
    </div>
  </header>
</template>

<style scoped>
/* Support du mode sombre pour les éléments */
.dark {
  --bg-color: #333;
  --text-color: #eee;
}
</style>
