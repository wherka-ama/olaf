# Windsurf Context Management Update

## Overview

This document outlines an improvement in how we provide core operational context to our AI assistant in Windsurf (Cascade). We have transitioned from a prompt-driven approach to an automated system using Windsurf's native **Rules** feature.

## What Has Changed?

Previously, the assistant was instructed via `team.md` to read and memorize key context files at the beginning of each session. This process has been replaced.

The following core files have been converted into Windsurf Rules set to 'Always One' so that they are always available to the assistant:

-   `competency-index.md`
-   `memory-map.md`
-   `core-principles.md`

## How It Works Now

As Windsurf Rules, these files are now **automatically loaded** into the assistant's context at the start of every session. There is no longer a need to explicitly instruct the assistant to read them.

## Benefits

-   **Efficiency**: Reduces session startup time and eliminates redundant instructions.
-   **Consistency**: Ensures core context is always present and correctly loaded without manual intervention, despite some models difficulty in following instructions or correctly calling the right agent functions.
-   **Simplicity**: Streamlines the user interaction, as the initial setup is now fully automated.
