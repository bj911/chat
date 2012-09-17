class Smaley
  def self.glyphs_smilies(text)
    [
        [/\"\:\-?\)\"/, '<img src="/assets/post/smiley.gif", alt="smiley"/>'],
        [/\"\;\-?\)\"/, '<img src="/assets/post/wink.gif", alt="wink" />'],
        [/\"\:\-?\(\"/, '<img src="/assets/post/sad.gif" alt="sad" />'],
        [/\"\;\-?\D\"/, '<img src="/assets/post/grin.gif", alt="grin"/>'],
        [/\"\!\:\(\"/, '<img src="/assets/post/angry.gif", alt="angry" />'],
        [/\"\:\-?\D\"/, '<img src="/assets/post/cheesy.gif", alt="cheesy"/>']
    ].each { |smile| text.gsub!(smile.first, smile.last) }
    text
  end
end