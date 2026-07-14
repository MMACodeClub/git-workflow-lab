import assert from 'node:assert/strict';
import { profiles } from '../src/profiles/index.js';
import { conflictTopics, teamColors } from '../src/workshop-config.js';

const allowedTeams = ['A', 'B', 'C', 'D', 'E'];

assert.equal(profiles.length, 10, 'Es müssen genau zehn Profile existieren.');
assert.deepEqual(profiles.map(({ id }) => id), [1,2,3,4,5,6,7,8,9,10], 'Profil-IDs müssen 1 bis 10 entsprechen.');
assert.deepEqual(Object.keys(conflictTopics), allowedTeams, 'Es müssen fünf Konflikt-Themen existieren.');
assert.deepEqual(Object.keys(teamColors), allowedTeams, 'Jedes Team braucht eine Farbe.');

for (const profile of profiles) {
  assert.ok(allowedTeams.includes(profile.team), `Profil ${profile.id}: Team ist ungültig.`);
  assert.equal(typeof profile.ready, 'boolean', `Profil ${profile.id}: ready muss true oder false sein.`);
  if (profile.ready) {
    assert.ok(profile.name.trim().length >= 2, `Profil ${profile.id}: Name fehlt.`);
    assert.ok(profile.strength.trim().length >= 3, `Profil ${profile.id}: Stärke fehlt.`);
    assert.notEqual(profile.name, 'Offen', `Profil ${profile.id}: Platzhalter-Name wurde nicht ersetzt.`);
  }
}

for (const [team, topic] of Object.entries(conflictTopics)) {
  assert.ok(topic.title.length > 3, `Team ${team}: Titel fehlt.`);
  assert.ok(topic.decision.length > 3, `Team ${team}: Entscheid fehlt.`);
}

console.log(`✓ ${profiles.length} Profile validiert`);
console.log(`✓ ${Object.keys(conflictTopics).length} Konflikt-Themen validiert`);
console.log('✓ Workshop-Daten sind konsistent');

