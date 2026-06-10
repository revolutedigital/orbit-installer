#![allow(dead_code)] // variant Navigate never constructed in Input
use crate::prelude::*;

page!(Completed {
    // v0.2.7: gate "removi o pendrive" — sem isso, leigo reinicia, boota do
    // pendrive de novo, abre o instalador, fica em loop e culpa o Orbit.
    pendrive_removed: bool,
}:
    init(root, sender, model, widgets) {}
    update(self, message, sender) {
        Reboot => {
            // supposedly it should run pkexec automatically?
            _ = std::process::Command::new("systemctl")
                .arg("reboot")
                .status();
        },
        Close => sender
            .output(CompletedPageOutput::Navigate(NavigationAction::Quit))
            .unwrap(),
        PendriveRemovedToggled(checked) => {
            self.pendrive_removed = checked;
        }
    } => {}

    gtk::Box {
        set_orientation: gtk::Orientation::Vertical,
        set_spacing: 16,
        set_vexpand: true,
        set_valign: gtk::Align::Center,
        set_halign: gtk::Align::Center,

        gtk::Image {
            set_icon_name: Some(&crate::CONFIG.read().distro.icon),
            inline_css: "-gtk-icon-size: 128px",
        },

        gtk::Label {
            #[watch]
            set_label: &t!("page-completed-desc"),
            set_justify: gtk::Justification::Center,
            set_max_width_chars: 60,
            set_wrap: true
        },

        // v0.2.7: checkbox gate "já retirei o pendrive" — sem isso, leigo
        // reinicia, boota do pendrive de novo, abre o instalador, loop.
        gtk::CheckButton {
            #[watch]
            set_label: Some(&t!("page-completed-pendrive-check")),
            set_margin_top: 12,
            connect_toggled[sender] => move |btn| {
                sender.input(CompletedPageMsg::PendriveRemovedToggled(btn.is_active()));
            },
        },
    },

    gtk::Box {
        set_spacing: 4,

        libhelium::Button {
            set_is_textual: true,
            #[watch]
            set_label: &t!("page-completed-close"),
            add_css_class: "large-button",
            connect_clicked => CompletedPageMsg::Close,
        },

        gtk::Box {
            set_hexpand: true,
        },

        libhelium::Button {
            // v0.2.7: Reiniciar só habilita quando o checkbox tá marcado.
            #[watch]
            set_sensitive: model.pendrive_removed,
            set_is_pill: true,
            #[watch]
            set_label: &t!("page-completed-reboot"),
            add_css_class: "large-button",
            connect_clicked => CompletedPageMsg::Reboot,
        }
    }
);
