
import 'package:test/test.dart';
import 'package:youtube_subs/youtube_subs.dart';

void main() {
  test('runs', () {
    final subs = YouTubeSubs.fromString(r'''hello there, it's march 13. i want to give you a little update on the sample flutter game that i'm working on. just so i think it's better to show it in motion at this point rather than, you know, giving you updates in the doc. which, of course, the dock is still open and still updated. all right. so i have it here in uh on an ipad. and here on an android device. and also well i can i can show you later but um i guess the game is for mobile phones so this is probably the the most important a salient part. i'll open it i think i think you can i think you can hear that it has music. i think you can maybe see uh yeah i think you can see what's what's going on there? so we have the play button of course. we have achievements, leaderboards and settings. if i click on leaderboards, for example, i get the leaderboards which currently has one person on it. which is me. and then achievements. i haven't like added actual achievements but it works. it just says there are no achievements right now. cool. all right. so i can go to play. you can hear there's a little bit of uh sound as well. so and and there's also this kind of um custom transition. i can select a level uh which are now... i love the sounds. i i kind of like them. um then uh i mean what was i saying... yeah oh the the music, of course, is um... we have all the the rights to to use it. it's uh cc0 and cc by. but i also have a permission from the author to use it for this particular project, and even include the audio files in the github repository so everyone can use them. and this is great music for these types of games. played on a mobile phone with pretty bad speakers. great great stuff! okay cool. so uh, again, what i wanted to show you is

that it all works okay. so i'll i'll win a game if i can i can do that.''');
   expect(() => subs.render(), returnsNormally);
  });
}