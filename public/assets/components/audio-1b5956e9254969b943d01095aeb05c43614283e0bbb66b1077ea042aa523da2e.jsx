var Audio = React.createClass({

  getInitialState: function() {
    return {
      player: false
    }
  },

  componentDidMount: function() {
    var $player = $('#' + this.props.id);

    /**
      * Have to add media event listeners here.
      *
    */
    $player.on('play', (e) => {
      e.preventDefault();
      this.playLocation();
    });

    $player.on('pause', (e) => {
      e.preventDefault();
      this.pause();
    });

    $player.on('ended', (e) => {
      e.preventDefault();
      this.ended();
    });

    $(document).on('keydown', (e) => {
      // Move currentTime forward and backward via arrow keys and play/pause via spacebar.
      if (e.keyCode == 39) {
        this.state.player.currentTime += 1;
      } else if (e.keyCode == 37) {
        this.state.player.currentTime -= 1;
      } else if (e.keyCode == 32 && this.state.player.paused == true) {
        e.preventDefault();
        this.state.player.play();
      }  else if (e.keyCode == 32 && this.state.player.paused == false) {
        e.preventDefault();
        this.state.player.pause()
      }
    });

    $player.on('wheel', (e) => {
      e.preventDefault();
      e.stopPropagation();
      // $player.focus();
      if (e.originalEvent.wheelDelta > 0) {
        this.state.player.currentTime += 1;
      } else {
        this.state.player.currentTime -= 1;
      }
    });
  },

  componentWillUnmount: function() {
    var $player = $('#' + this.props.id);
    $player.off('play');
    $player.off('pause');
    $(document).off('keydown')
    $player.off('wheel')
  },

  getPlaybackTime: function(time) {
    var hours = Math.floor(time / 3600);
    var minutes = Math.floor(time / 60);
    if (minutes > 59) {
      minutes = Math.floor(time / 60) - 60;
    }

    var seconds = Math.round(time - minutes * 60);
    if (seconds > 3599) {
      seconds = Math.round(time - minutes * 60) - 3600;
    }

    return time;
  },

  playLocation: function() {
    this.setState({player: $('#' + this.props.id)[0]}, function() {
      var playbackTime = this.getPlaybackTime(this.state.player.currentTime);

      $.get('/audios/' + this.props.id + '.json').then( (data) => {
        this.state.player.currentTime = data.playback_time;
        this.state.player.play();
      });
    });
  },

  pause: function() {
    var playbackTime = this.getPlaybackTime(this.state.player.currentTime);

    // Do the putting.
    $.ajax({
      url: '/audios/' + this.props.id  + '.json',
      method: 'put',
      data: 'audio[playback_time]=' + playbackTime
    });
  },

  ended: function() {
    // Set playback_time to 0.
    $.ajax({
      url: '/audios/' + this.props.id  + '.json',
      method: 'put',
      data: 'audio[playback_time]=' + 0
    });

    $(document).trigger('playback-ended');
  },

  render: function() {
    return <audio id={this.props.id} controls className="player" preload="false">
      <source src={this.props.audio.path.indexOf('http') ? '/stream/' + this.props.id : this.props.audio.path} />
    </audio>
  }
});