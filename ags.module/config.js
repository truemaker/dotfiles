import Gdk from "gi://Gdk"

const hyprland = await Service.import('hyprland');
const notifications = await Service.import('notifications');
const mpris = await Service.import('mpris');
const audio = await Service.import('audio');
const battery = await Service.import('battery');
const systemtray = await Service.import('systemtray');

import MediaWidget from './Media.js';
import NotificationPopups from './NotificationPopups.js';

function range(length, start = 1) {
  return Array.from({ length }, (_, i) => i + start)
}

function forMonitors(widget) {
  const n = Gdk.Display.get_default()?.get_n_monitors() || 1
  return range(n, 0).map(widget).flat(1)
}

const media_win = Widget.Window({
  name: 'mpris',
  anchor: ['bottom', 'left'],
  child: Widget.Box({
    css: `padding: 1px;`,
    children: [Widget.Revealer({
      child: MediaWidget(),
      transition: "slide_right",
      reveal_child: false,
    })],
  }),
});

const date = Variable('', {
  poll: [1000, 'date "+%d.%m.%y %H:%M:%S"'],
});

function Workspaces() {
  const workspaces = hyprland.bind('workspaces');
  const activeId = hyprland.active.workspace.bind('id');
  return Widget.Box({
    class_name: 'workspaces',
    children: workspaces.as(ws => ws.filter(({ id }) => id > 0).sort((a, b) => a.id > b.id).map(({ id }) => Widget.Button({
      on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
      child: Widget.Label(`${id}`),
      class_name: activeId.as(i => `${i === id ? 'focused' : ''}`),
    }))),
  });
}

const ClientTitle = () => Widget.Label({
  class_name: 'client-title',
  label: hyprland.active.client.bind('title'),
});

const Clock = () => Widget.Label({
  class_name: 'clock',
  label: date.bind(),
});

const HyprSplash = () => Widget.Label({
  class_name: 'hypr-splash',
  label: hyprland.message("/splash"),
});

const EasyEffects = () => Widget.Button({
  on_primary_click: () => { Utils.execAsync("easyeffects") },
  child: Widget.Icon({
    icon: 'audio-card-symbolic'
  }),
});

function Notification() {
  const popups = notifications.bind('popups');
  return Widget.Box({
    class_name: 'notification',
    visible: popups.as(p => p.length > 0),
    children: [
      Widget.Icon({
        icon: 'preferences-system-notifications-symbolic',
      }),
      Widget.Label({
        label: popups.as(p => p[0]?.summary || ''),
      }),
    ],
  });
}

/*const Player = player => Widget.Button({
    on_primary_click: () => player.playPause(),
    on_scroll_up: () => player.next(),
    on_scroll_down: () => player.previous(),
    child: Widget.Label().hook(player, label => {
        const { track_artists, track_title } = player;
        label.label = `${track_artists.join(', ')} - ${track_title}`;
    }),
});*/

const Media = () => Widget.Button({
  on_primary_click: () => { App.getWindow('mpris').child.children[0].reveal_child = !App.getWindow('mpris').child.children[0].reveal_child },
  child: Widget.Icon({
    icon: 'audio-x-generic-symbolic',
  }),
}).hook(mpris, self => {
  if (mpris.players.length == 0) {
    self.visible = false;
    App.getWindow('mpris').child.children[0].reveal_child = false;
  } else {
    self.visible = true;
  }
});
/*Widget.Box({
    children: mpris.bind('players').as(p => p.map(Player)),
});*/

const Volume = () => Widget.Box({
  class_name: 'volume',
  children: [
    Widget.Icon({
      icon: audio.speaker.bind("volume").as(p => {
        const category = {
          101: 'overamplified',
          67: 'high',
          34: 'medium',
          1: 'low',
          0: 'muted',
        };

        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
          threshold => threshold <= audio.speaker.volume * 100);

        return `audio-volume-${category[icon]}-symbolic`
      })
    }),
    /* Widget.Slider({
        hexpand: true,
        draw_value: false,
        on_change: ({ value }) => audio.speaker.volume = value,
        setup: self => self.hook(audio.speaker, () => {
            self.value = audio.speaker.volume || 0;
        }),
    })*/
    Widget.Label({
      label: audio.speaker.bind('volume').as(p => `${audio.speaker.is_muted ? 0 : Math.floor((p > 0 ? p : 0) * 100)}%`)
    }),
  ],
});

const BatteryLabel = () => Widget.Box({
  class_name: 'battery',
  visible: battery.bind('available'),
  children: [
    Widget.Icon({
      icon: battery.bind('percent').as(p =>
        `battery-level-${Math.floor(p / 10) * 10}-symbolic`,
      ),
    }),
    /*Widget.ProgressBar({
        vpack: 'center',
        fraction: battery.bind('percent').as(p =>
            p > 0 ? p / 100 : 0,
        ),
    }),*/
    Widget.Label({
      label: battery.bind('percent').as(p => `${p > 0 ? p : 0}%`)
    }),
  ],
});

const SysTray = () => Widget.Box({
  class_name: 'trays',
  children: systemtray.bind('items').as(items =>
    items.map(item => Widget.Button({
      child: Widget.Icon({ icon: item.bind('icon') }),
      on_primary_click: (_, event) => item.activate(event),
      on_secondary_click: (_, event) => item.openMenu(event),
      tooltip_markup: item.bind('tooltip_markup'),
    })),
  ),
});

// layout of the bar
const TopLeft = () => Widget.Box({
  spacing: 8,
  children: [
    Clock(),
    ClientTitle(),
  ],
});

const TopCenter = () => Widget.Box({
  spacing: 8,
  children: [
    Workspaces(),
  ],
});

const TopRight = () => Widget.Box({
  hpack: 'end',
  spacing: 8,
  children: [
    Volume(),
    BatteryLabel(),
    SysTray(),
    Widget.Button({
      on_primary_click: () => { App.toggleWindow('bottom-bar') },
      child: Widget.Icon({
        icon: 'open-menu-symbolic',
      }),
    }),
    Media(),
  ],
});

const BottomCenter = () => Widget.Box({
  spacing: 8,
  children: [
    EasyEffects(),
  ],
});

const TopBar = (monitor = 0) => Widget.Window({
  name: `bar-${monitor}`, // name has to be unique
  class_name: 'bar',
  monitor,
  anchor: ['top', 'left', 'right'],
  exclusivity: 'exclusive',
  child: Widget.CenterBox({
    start_widget: TopLeft(),
    center_widget: TopCenter(),
    end_widget: TopRight(),
  }),
});

const BottomBar = (monitor = 0) => Widget.Window({
  name: `bottom-bar`, // name has to be unique
  class_name: 'bar',
  monitor,
  anchor: ['bottom', 'left', 'right'],
  exclusivity: 'ignore',
  child: Widget.CenterBox({
    center_widget: BottomCenter(),
  }),
  visible: false,
});

App.config({
  style: './style.css',
  windows: [
    ...forMonitors(TopBar),
    BottomBar(),
    media_win,
    ...forMonitors(NotificationPopups),
  ]
});

const styleMonitor = Utils.monitorFile(`${App.configDir}`, function() {
  App.resetCss();
  App.applyCss(`${App.configDir}/style.css`);
});
