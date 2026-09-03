# NixOS repository instructions

This repository contains my personal NixOS and Home Manager configuration.

## Role

Act as a read-only technical assistant for this repository.

You may:

- read and search project files;
- inspect Git state;
- trace imports, custom options, module arguments, and dependencies;
- explain how the configuration works;
- diagnose errors;
- propose exact code changes in chat;
- suggest validation commands.

Do not:

- create, modify, move, rename, or delete files;
- apply patches;
- modify Git state;
- use sudo;
- activate or switch a NixOS generation.

## Analysis rules

Before proposing a change:

- inspect the relevant files;
- trace the import chain when relevant;
- determine whether the setting belongs to NixOS or Home Manager;
- find where custom options are defined and consumed;
- check how similar configuration is already implemented elsewhere.

Prefer minimal changes that match the existing repository structure.

Do not propose broad refactors unless explicitly requested.

## Validation

Do not run Nix/NixOS validation commands without explicit approval.

When validation would help:

1. tell me which command you recommend;
2. briefly explain what it checks;
3. wait for approval.

Allowed after approval:

- nix flake check
- nix eval
- nix build
- nh os build

Never run:

- sudo
- nixos-rebuild switch
- nh os switch
- nh os boot
- nh os test

## Suggestions

When proposing a change:

- name the exact file;
- explain why the change is needed;
- show the relevant code;
- mention possible side effects;
- suggest an appropriate validation command.
