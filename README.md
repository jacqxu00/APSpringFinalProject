# APSpringFinalProject
Peter Lee and Jacqueline Xu

<h2>About</h2>
<p>Inspired by Super Bomberman 5 (SNES)</p>
<p>Sprite credits go to <a href="https://www.spriters-resource.com/snes/sbomber5/">zanaku</a></p>
<hr>

<h2>How To Play</h2>
<ol>
<li>Install all files</li>
<li>Run any pde files</li>
<li>Press play</li>
<li>Use arrow keys to move the main character</li>
<li>Use space bar to drop bombs</li>
<li>Kill all the monsters and find the portal to get to the next level!</li>
</ol>
<hr>


<h2>Features</h2>
<ul>
<li>6/3/17 - Random placement of brick walls</li>
<li>6/4/17 - Bomberman can move around successfully with sprites</li>
<li>6/6/17 - Wall detection: Bomberman won't walk into walls</li>
<li>6/9/17 - Bomb detection: Attackers won't walk through bombs</li>
<li>6/11/17 - Bomb animation and exploding</li>
<li>6/12/17 - Attacker movement: changes to random direction when it reaches dead end</li>
<li>6/13/17 - Successful explosion: fires kill creatures </li>
<li>6/15/17 - Portal successful: new level when player kills all monsters and reaches portal</li>
<li>6/16/17 - Items successful: items placed at certain levels, and when picked up will work</li>
</ul>
<hr>

<h2>Bugs</h2>
<ul>
<li>Although the field is sort of "3D," the creatures are not always drawn so that the one in the front is displayed on top</li>
<li>Specific situations may cause the creatures to get locked in place, unable to move
<ul><li>Solution: Press 'R' to reset the character coordinates</li></ul>
</li>
<li>The monsters are not extremely "smart": when they reach a bomb they don't turn around</li>
<li>For some reason, multiple bombs won't work. When you get multiple bombs and you press SPACE to drop a bomb, it automatically puts multiple bombs in that spot. We thought it was because keyPress will continually run true when a key is pressed, but when we tried to remedy that it didn't work, and we couldn't figure it out</li>
</ul>






