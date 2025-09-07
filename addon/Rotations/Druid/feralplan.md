# Feral Druid Rotation Requirements Document

## Overview

This document outlines the requirements for a comprehensive Feral Druid rotation system for WotLK Classic, focusing on both DPS and Tank specializations with dynamic single-target and AoE capabilities.

## Core Architecture

### 1. Specialization Detection System

- **Detection Method**: Talent-based using "Protector of the Pack" (≥3 points = Tank, <3 = DPS)
- **Update Events**:
  - PLAYER_ENTERING_WORLD
  - ACTIVE_TALENT_GROUP_CHANGED
- **Storage**: Persistent PlayerSpec variable maintained between cycles

### 2. Dynamic Queue System

- **Four distinct queues**:
  - DPS Single-Target
  - DPS AoE (≥3 enemies)
  - Tank Single-Target
  - Tank AoE (≥3 enemies)
- **Selection Logic**: Based on specialization and enemy count
- **Execution Flow**: Always process cache and defensives first, then specialization-specific logic

### 3. Caching System Requirements

- **Purpose**: Minimize API calls through comprehensive data caching
- **Base Cache Fields**:
  - Player states: HP, current form, combat status
  - Target states: existence, HP, TTD
  - Environment: enemies within 8 yards
- **Specialization-Specific Cache**:
  - DPS: energy, combo points, target position, threat status
  - Tank: rage, Lacerate stacks, Demoralizing Roar status

### 4. Rotation Priorities

#### DPS Single-Target:

1. Maintain debuffs (Mangle, Rake)
2. Generate combo points
3. Execute finishers (Savage Roar, Rip, Ferocious Bite)
4. Energy management (Tiger's Fury, Powershifting)

#### DPS AoE:

1. Target selection: highest health enemy
2. Maintain Savage Roar
3. Build combo points with single-target abilities
4. Swipe spam when energy available
5. Powershifting for energy regeneration

#### Tank Single-Target:

1. Maintain debuffs (Demoralizing Roar, Lacerate 5 stacks)
2. Mangle on cooldown
3. Maul as rage dump
4. Swipe for multi-target threat

#### Tank AoE:

1. Swipe and Maul spam
2. Maintain Demoralizing Roar
3. Active threat monitoring per unit
4. Targeted taunt with Growl or Faerie Fire

### 5. Threat Management

- **DPS**: Automatic response to high threat (≥90%)
  - Primary: Shadowmeld (if available)
  - Fallback: Switch to bear form
- **Tank**: Continuous threat monitoring with targeted responses

### 6. Defensive System

- **Health-based responses**:
  - Survival Instinct <30%
  - Barkskin <50%
  - Consumables <20%
  - Frenzied Regeneration (Tank) <20%
- **Threat-based responses** (DPS only)

### 7. Pre-Pull System Requirements

- **DBM Integration**: Detect "Pull in" timer
- **Pre-Pull Actions**:
  - Gift of the Wild casting for Clearcasting proc
  - Potion usage (configurable flag)
  - Form preparation (Cat form before pull)
- **Activation Threshold**: 0.2 seconds before pull timer ends
- **Cancel Condition**: Entering combat cancels pre-pull actions

### 8. Engineering Gloves Integration

- **Synapse Springs Coordination**:
  - Primary: Use with Berserk for maximum alignment
  - Secondary: Use when Berserk cooldown >60 seconds and in combat
- **Activation Conditions**:
  - Must be in melee range
  - Must be in combat
  - Engineering profession detected

### 9. Slash Command System

- **Manual Override Commands**:
  - `/STUNT`: Bash current target
  - `/shred`: Position-aware Shred/Mangle sequence
  - `/charges`: Feral Charge on mouseover
  - `/stopgasting`: Pause rotation for 1 second (manual spell casting)
  - `/heal`: Emergency self-heal sequence
- **Implementation**: All commands should interrupt automatic rotation when used

### 10. Interrupt System

- **Available Interrupts**:
  - Bash (Bear form)
  - Feral Charge (Bear form)
  - Maim (Cat form, requires combo points)
  - Native racial abilities
- **Configuration**: Toggle for automatic interrupt usage

### 11. Stop Conditions

- **Rotation Pause Conditions**:
  - Mounted
  - Dead or ghost
  - Not in combat
  - Channeling spells
  - Drinking
  - Manual pause via slash command
- **Implementation**: Check these conditions before any rotation logic

### 12. Consumables Management

- **Automatic Detection**: Healthstones and potions
- **Usage Logic**: Health-based with configurable thresholds
- **Update Events**: BAG_UPDATE and PLAYER_REGEN_ENABLED

### 13. Cooldown Alignment

- **Berserk Usage**:
  - With Tiger's Fury active
  - With engineering gloves (Synapse Springs)
  - During execute phases (<25% target health)
- **Optimization**: Align major cooldowns for maximum burst windows

### 14. Configuration GUI

- **Toggle Options**:
  - Auto Cat form
  - Auto Prowl
  - Clearcasting hunting
  - Full automated rotation
  - Bomb usage
  - PvP abilities (Berserk fear break, Charge interrupt, etc.)
  - Interrupt settings
- **Sliders/Inputs**:
  - Health thresholds for defensives
  - Threat thresholds for responses
  - AoE target count thresholds

### 15. Performance Optimization

- **API Call Minimization**: Extensive caching of all reusable data
- **Event-Driven Updates**: Only update cache when necessary
- **Efficient Loops**: Minimize iterations in threat monitoring and enemy scanning

## Technical Implementation Notes

1. **Modular Design**: Separate functionality into discrete, testable components
2. **DRY Compliance**: Reuse common logic through helper functions
3. **Error Handling**: Graceful degradation when API data is unavailable
4. **Memory Efficiency**: Minimal variable creation, maximum reuse
5. **Execution Flow**:
   - Stop conditions check
   - Cache update
   - Defensive responses
   - Specialization detection
   - Queue selection
   - Ability execution

This requirements document provides a comprehensive foundation for implementing a high-performance Feral Druid rotation system that handles both specializations and adapts dynamically to combat conditions.
