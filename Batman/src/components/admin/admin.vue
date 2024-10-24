<template>
  <div class="p-6">
    <h1 class="text-3xl font-semibold mb-4">User Management page</h1>
    <div class="mb-4">
      <button @click="openCreateModal"
        class="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 mr-2 font-semibold">
        Create a User
      </button>
    </div>
    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
      <table class="min-w-full divide-y divide-gray-200">
        <thead>
          <tr>
            <th
              class="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">
              Username
            </th>
            <th
              class="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">
              Email
            </th>
            <th
              class="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">
              Role
            </th>
            <th
              class="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">
              Teams
            </th>
            <th class="px-6 py-3 bg-gray-50 text-right"></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="user in userList" :key="user.id">
            <td class="px-6 py-4 whitespace-no-wrap text-teal-500">
              <router-link class="hover:underline" :to="`/${user.id}`">{{
                user.username
              }}</router-link>
            </td>
            <td class="px-6 py-4 whitespace-no-wrap">{{ user.email }}</td>
            <td class="px-6 py-4 whitespace-no-wrap">{{ user.role }}</td>
            <td class="px-6 py-4 whitespace-no-wrap">{{ user.teamId }}</td>
            <td class="px-6 py-4 whitespace-no-wrap text-right">
              <button @click="openUpdateModal(user)" class="text-indigo-600 hover:text-indigo-900 font-semibold mx-2">
                Update
              </button>
              <button @click="openDeleteModal(user.id)" class="text-red-600 hover:text-red-900 font-semibold mx-2">
                Delete
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Modal delete user -->
    <div v-if="isDeleteModalOpen"
      class="fixed inset-0 flex items-center justify-center z-10 overflow-x-hidden overflow-y-auto"
      @click="cancelDelete">
      <div class="bg-black opacity-50 fixed inset-0"></div>
      <div class="bg-white w-96 p-6 rounded-lg shadow-lg relative" @click.stop>
        <h3 class="text-lg font-semibold mb-4">Confirm Delete</h3>
        <p class="text-gray-700 mb-4">
          Are you sure you want to delete this user?
        </p>
        <div class="flex justify-end">
          <button @click="confirmDelete"
            class="bg-red-500 text-white px-4 py-2 rounded-full hover:bg-red-600 mr-2 font-semibold">
            Delete
          </button>
          <button @click="cancelDelete"
            class="bg-gray-300 text-gray-700 px-4 py-2 rounded-full hover:bg-gray-400 font-semibold">
            Cancel
          </button>
        </div>
      </div>
    </div>

    <!-- Modal update user -->
    <div v-if="isUpdateModalOpen"
      class="fixed inset-0 flex items-center justify-center z-10 overflow-x-hidden overflow-y-auto"
      @click="cancelUpdate">
      <div class="bg-black opacity-50 fixed inset-0"></div>
      <div class="bg-white w-96 p-6 rounded-lg shadow-lg relative" @click.stop>
        <h3 class="text-lg font-semibold mb-4">Mettre à jour l'utilisateur</h3>
        <div class="mb-4">
          <label for="updatedUsername" class="block text-sm font-medium text-gray-700">Username</label>
          <input v-model="updatedUser.username" type="text" id="updatedUsername" name="updatedUsername"
            class="form-input" />
        </div>
        <div class="mb-4">
          <label for="updatedEmail" class="block text-sm font-medium text-gray-700">Email</label>
          <input v-model="updatedUser.email" type="text" id="updatedEmail" name="updatedEmail" class="form-input" />
        </div>
        <div class="mb-4">
          <label for="updatedRole" class="block text-sm font-medium text-gray-700">Role</label>
          <select v-model="updatedUser.role" id="updatedRole" name="updatedRole" class="form-select">
            <option value="employee">Employee</option>
            <option value="manager">Manager</option>
            <option value="generalManager">General Manager</option>
            <option value="admin">Admin</option>
          </select>
        </div>
        <div class="flex justify-end">
          <button @click="updateUser"
            class="bg-indigo-500 text-white px-4 py-2 rounded-full hover:bg-indigo-600 mr-2 font-semibold">
            Update
          </button>
          <button @click="cancelUpdate"
            class="bg-gray-300 text-gray-700 px-4 py-2 rounded-full hover:bg-gray-400 font-semibold">
            Cancel
          </button>
        </div>
      </div>
    </div>

    <!-- Modal update team -->
    <div v-if="isUpdateTeamModalOpen"
      class="fixed inset-0 flex items-center justify-center z-10 overflow-x-hidden overflow-y-auto"
      @click="cancelUpdateTeam">
      <div class="bg-black opacity-50 fixed inset-0"></div>
      <!-- Fond sombre -->
      <div class="bg-white w-96 p-6 rounded-lg shadow-lg relative" @click.stop>
        <h3 class="text-lg font-semibold mb-4">
          Mettre à jour l'équipe de l'utilisateur
        </h3>
        <div class="mb-4">
          <label for="updatedTeam" class="block text-sm font-medium text-gray-700">Équipe</label>
          <select v-model="updatedUser.teamId" id="updatedTeam" name="updatedTeam" class="form-select">
            <option v-for="team in teamList" :key="team.id" :value="team.id">
              {{ team.name }}
            </option>
          </select>
        </div>
        <div class="flex justify-end">
          <button @click="updateUserTeam"
            class="bg-indigo-500 text-white px-4 py-2 rounded-full hover:bg-indigo-600 mr-2 font-semibold">
            Update
          </button>
          <button @click="cancelUpdateTeam"
            class="bg-gray-300 text-gray-700 px-4 py-2 rounded-full hover:bg-gray-400 font-semibold">
            Cancel
          </button>
        </div>
      </div>
    </div>

    <!-- Modal pour la création de l'utilisateur -->
    <div v-if="isCreateModalOpen"
      class="fixed inset-0 flex items-center justify-center z-10 overflow-x-hidden overflow-y-auto"
      @click="cancelCreate">
      <div class="bg-black opacity-50 fixed inset-0"></div>
      <!-- Fond sombre -->
      <div class="bg-white w-96 p-6 rounded-lg shadow-lg relative" @click.stop>
        <h3 class="text-lg font-semibold mb-4">Créer un nouvel utilisateur</h3>
        <div class="mb-4">
          <label for="newUsername" class="block text-sm font-medium text-gray-700">Username</label>
          <input v-model="newUser.username" type="text" id="newUsername" name="newUsername" class="form-input" />
        </div>
        <div class="mb-4">
          <label for="newEmail" class="block text-sm font-medium text-gray-700">Email</label>
          <input v-model="newUser.email" type="text" id="newEmail" name="newEmail" class="form-input" />
        </div>
        <div class="mb-4">
          <label for="newPassword" class="block text-sm font-medium text-gray-700">Password</label>
          <input v-model="newUser.password" type="password" id="newPassword" name="newPassword" class="form-input" />
        </div>
        <div class="flex justify-end">
          <button @click="createUser"
            class="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 mr-2 font-semibold">
            Create
          </button>
          <button @click="cancelCreate"
            class="bg-gray-300 text-gray-700 px-4 py-2 rounded-full hover-bg-gray-400 mr-2 font-semibold">
            Cancel
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Cookies from "js-cookie";

export default {
  name: "GeneralManager",
  data() {
    return {
      BASE_URL: "http://localhost:4000",
      userList: [],
      isUpdateModalOpen: false,
      isCreateModalOpen: false,
      isUpdateTeamModalOpen: false,
      isDeleteModalOpen: false,
      userIdToDelete: null,
      teamList: [],
      updatedUser: {
        username: "",
        email: "",
        role: "",
      },
      newUser: {
        username: "",
        email: "",
        password: "",
        role: "",
      },
    };
  },
  created() {
    this.fetchUserList();
  },
  methods: {
    fetchUserList() {
      axios
        .get(`${this.BASE_URL}/api/users/all`, {
          headers: { Authorization: `Bearer ${Cookies.get("token")}` },
        })
        .then((response) => {
          this.userList = response.data.data.map((user) => {
            return {
              id: user.id,
              username: user.username,
              email: user.email,
              role: user.role,
              teamName: "",
            };
          });

          this.userList.forEach((user) => {
            axios
              .get(`${this.BASE_URL}/api/teams/${user.teamId}`, {
                headers: { Authorization: `Bearer ${Cookies.get("token")}` },
              })
              .then((teamResponse) => {
                user.teamName = teamResponse.data.data.name;
              })
              .catch((error) => {
                console.error("Error fetching team information: ", error);
              });
          });
        })
        .catch((error) => {
          console.error(
            "Erreur lors de la récupération des utilisateurs : ",
            error
          );
        });
    },
    openUpdateModal(user) {
      this.updatedUser = { ...user };
      this.isUpdateModalOpen = true;
      this.fetchTeamList();
    },
    updateUser() {
      axios
        .put(
          `${this.BASE_URL}/api/users/${this.updatedUser.id}`,
          {
            user: {
              username: this.updatedUser.username,
              email: this.updatedUser.email,
              role: this.updatedUser.role,
            },
          },
          { headers: { Authorization: `Bearer ${Cookies.get("token")}` } }
        )
        .then((response) => {
          this.isUpdateModalOpen = false;
          this.fetchUserList();
        })
        .catch((error) => {
          console.error(
            "Erreur lors de la mise à jour de l'utilisateur : ",
            error
          );
        });
    },
    cancelUpdate() {
      this.isUpdateModalOpen = false;
    },
    openCreateModal() {
      this.isCreateModalOpen = true;
    },
    createUser() {
      axios
        .post(
          `${this.BASE_URL}/api/auth/users`,
          {
            user: {
              username: this.newUser.username,
              email: this.newUser.email,
              password: this.newUser.password,
            },
          },
          { headers: { Authorization: `Bearer ${Cookies.get("token")}` } }
        )
        .then((response) => {
          this.isCreateModalOpen = false;
          this.fetchUserList();
          this.newUser = { username: "", email: "", password: "" };
        })
        .catch((error) => {
          console.error(
            "Erreur lors de la création de l'utilisateur : ",
            error
          );
        });
    },
    cancelCreate() {
      this.isCreateModalOpen = false;
      this.newUser = { username: "", email: "", password: "" };
    },

    openDeleteModal(userId) {
      this.userIdToDelete = userId;
      this.isDeleteModalOpen = true;
    },

    confirmDelete() {
      axios
        .delete(`${this.BASE_URL}/api/users/${this.userIdToDelete}`, {
          headers: { Authorization: `Bearer ${Cookies.get("token")}` },
        })
        .then(() => {
          this.isDeleteModalOpen = false;
          this.fetchUserList();
        })
        .catch((error) => {
          console.error("Error deleting user: ", error);
        });
    },

    cancelDelete() {
      this.isDeleteModalOpen = false;
      this.userIdToDelete = null;
    },

    fetchTeamList() {
      axios
        .get(`${this.BASE_URL}/api/teams`, {
          headers: { Authorization: `Bearer ${Cookies.get("token")}` },
        })
        .then((response) => {
          this.teamList = response.data.data.map((team) => {
            return {
              id: team.id,
              name: team.name,
            };
          });
        })
        .catch((error) => {
          console.error("Erreur lors de la récupération des équipes : ", error);
        });
    },

    openUpdateTeamModal(user) {
      this.updatedUser = { ...user };
      this.isUpdateTeamModalOpen = true;
    },

    updateUserTeam() {
      axios
        .patch(
          `${BASE_URL}/api/teams/${this.updatedUser.teamId}/${this.updatedUser.id}`,
          {},
          { headers: { Authorization: `Bearer ${Cookies.get("token")}` } }
        )
        .then((response) => {
          this.isUpdateTeamModalOpen = false;
          this.fetchUserList();
        })
        .catch((error) => {
          console.error(
            "Erreur lors de la mise à jour de l'équipe de l'utilisateur : ",
            error
          );
        });
    },

    cancelUpdateTeam() {
      this.isUpdateTeamModalOpen = false;
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
