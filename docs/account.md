# Account on macOS

There are two options here:

## As Admin User

This is the easiest way to get started. You can create an `admin user` and use
that for everything. However, it is not recommended to use an `admin user` for
day-to-day use.

## As Standard User

This is the recommended way to use macOS. You can create a `standard user` and
use that for day-to-day use. For administration purpose, you will need to create
additional account with `admin privileges`.

### Step 1: Create a Standard User

First, create a standard user account. You can do this by going to System
Preferences > Users & Groups > Add User. Let's name this user as `virajpatel`

### Step 2: Create an Admin User

Next, create an admin user account with name as `admin`.

### Step 3: Add standard user to sudoer (ONLY FOR ADVANCE USERS)

Go to terminal and run the following command:

```shell
# If you are logged in as standard user, you will have to switch to admin user context
su admin

# Use visudo to add the user account
sudo visudo

# Add the following line under %admin line
virajpatel ALL=(ALL) ALL
```

### Step 4: Install XCode Command-Line Tools & Rosetta

Go to terminal and run the following command:

```shell
softwareupdate --install --all --install-rosetta --agree-to-license
```
