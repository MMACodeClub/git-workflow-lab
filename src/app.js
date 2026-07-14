import { profiles } from './profiles/index.js';
import { conflictTopics, teamColors } from './workshop-config.js';

const profileGrid = document.querySelector('#profile-grid');
const decisionGrid = document.querySelector('#decision-grid');
const completedProfiles = profiles.filter((profile) => profile.ready).length;

document.querySelector('#completion-status').textContent = `${completedProfiles} / ${profiles.length} bereit`;

profileGrid.innerHTML = profiles.map((profile) => `
  <article class="profile-card ${profile.ready ? '' : 'pending'}" style="--team-color: ${teamColors[profile.team]}">
    <span class="profile-number">PERSON ${String(profile.id).padStart(2, '0')}</span>
    <h3>${profile.ready ? profile.name : 'Profil ausstehend'}</h3>
    <p>${profile.ready ? profile.strength : 'Wird im ersten Pull Request ergänzt.'}</p>
    <p class="team">Team ${profile.team}</p>
  </article>
`).join('');

decisionGrid.innerHTML = Object.entries(conflictTopics).map(([team, topic]) => `
  <article class="decision-card" style="--team-color: ${teamColors[team]}">
    <h3>Team ${team}: ${topic.title}</h3>
    <p class="decision-value">${topic.decision}</p>
    <p class="decision-note">${topic.note}</p>
  </article>
`).join('');

