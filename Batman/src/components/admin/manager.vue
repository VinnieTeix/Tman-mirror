<template>
  <div class="p-6">
    <h1 class="text-3xl font-semibold mb-4">Liste des Utilisateurs</h1>
    <div class="mb-4">
      <button @click="openCreateModal"
        class="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 mr-2">Create</button>
    </div>
    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
      <table class="min-w-full divide-y divide-gray-200">
        <thead>
          <tr>
            <th
              class="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">
              Username</th>
            <th
              class="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">
              Email</th>
            <th class="px-6 py-3 bg-gray-50 text-right"></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="user in userList" :key="user.id">
            <td class="px-6 py-4 whitespace-no-wrap">{{ user.username }}</td>
            <td class="px-6 py-4 whitespace-no-wrap">{{ user.email }}</td>
            <td class="px-6 py-4 whitespace-no-wrap text-right">
              <button @click="deleteUser(user.id)"
                class="text-red-600 hover:text-red-900 font-semibold mx-2">Delete</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Modal pour la création de l'utilisateur -->
    <div v-if="isCreateModalOpen"
      class="fixed inset-0 flex items-center justify-center z-10 overflow-x-hidden overflow-y-auto"
      @click="cancelCreate">
      <div class="bg-black opacity-50 fixed inset-0"></div> <!-- Fond sombre -->
      <div class="bg-white w-96 p-6 rounded-lg shadow-lg relative" @click.stop>
        <h3 class="text-lg font-semibold mb-4">Créer un nouvel utilisateur</h3>
        <div class="mb-4">
          <label for="newUsername" class="block text-sm font-medium text-gray-700">Username</label>
          <input v-model="newUser.username" type="text" id="newUsername" name="newUsername" class="form-input">
        </div>
        <div class="mb-4">
          <label for="newEmail" class="block text-sm font-medium text-gray-700">Email</label>
          <input v-model="newUser.email" type="text" id="newEmail" name="newEmail" class="form-input">
        </div>
        <div class="mb-4">
          <label for="newPassword" class="block text-sm font-medium text-gray-700">Password</label>
          <input v-model="newUser.password" type="password" id="newPassword" name="newPassword" class="form-input">
        </div>
        <div class="flex justify-end">
          <button @click="createUser"
            class="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 mr-2 font-semibold">Create</button>
          <button @click="cancelCreate"
            class="bg-gray-300 text-gray-700 px-4 py-2 rounded-full hover-bg-gray-400 mr-2 font-semibold">Cancel</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Cookies from 'js-cookie';

export default {
  name: "GeneralManager",
  data() {
    return {
      userList: [],
      isUpdateModalOpen: false,
      isCreateModalOpen: false,
      updatedUser: {
        username: "",
        email: "",
      },
      newUser: {
        username: "",
        email: "",
        password: "",
      },
    };
  },
  created() {
    this.fetchUserList();
  },
  methods: {
    fetchUserList() {
      axios
        .get("http://localhost:4000/api/users/all", { headers: { Authorization: `Bearer ${Cookies.get('token')}` } })
        .then((response) => {
          this.userList = response.data.data.map((user) => {
            return {
              id: user.id,
              username: user.username,
              email: user.email,
            };
          });
        })
        .catch((error) => {
          console.error("Erreur lors de la récupération des utilisateurs : ", error);
        });
    },
    openUpdateModal(user) {
      this.updatedUser = { ...user };
      this.isUpdateModalOpen = true;
    },
    cancelUpdate() {
      this.isUpdateModalOpen = false;
    },
    openCreateModal() {
      this.isCreateModalOpen = true;
    },
    createUser() {
      axios
        .post("http://localhost:4000/api/users", { "user": { "username": this.newUser.username, "email": this.newUser.email, "password": this.newUser.password } }, { headers: { Authorization: `Bearer ${Cookies.get('token')}` } })
        .then((response) => {
          this.isCreateModalOpen = false;
          this.fetchUserList();
          this.newUser = { username: "", email: "", password: "" };
        })
        .catch((error) => {
          console.error("Erreur lors de la création de l'utilisateur : ", error);
        });
    },
    cancelCreate() {
      this.isCreateModalOpen = false;
      this.newUser = { username: "", email: "", password: "" };
    },
    deleteUser(userId) {
      if (confirm("Êtes-vous sûr de vouloir supprimer cet utilisateur?")) {
        axios
          .delete(`http://localhost:4000/api/users/${userId}`)
          .then(() => {
            this.fetchUserList();
          })
          .catch((error) => {
            console.error("Erreur lors de la suppression de l'utilisateur : ", error);
          });
      }
    },
  },
};
</script>

<style scoped>
.bg-black {
  background-color: rgba(0, 0, 0, 0.5);
}

.btn-update {
  background-color: #4299e1;
  color: #fff;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 0.25rem;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-update:hover {
  background-color: #3182ce;
}

.btn-delete {
  background-color: #e53e3e;
  color: #fff;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 0.25rem;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-delete:hover {
  background-color: #c53030;
}

.btn-create {
  background-color: #48bb78;
  color: #fff;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 0.25rem;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-create:hover {
  background-color: #38a169;
}

.btn-cancel {
  background-color: #cbd5e0;
  color: #4a5568;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 0.25rem;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-cancel:hover {
  background-color: #a0aec0;
}

.rounded-lg {
  border-radius: 0.5rem;
}
</style>