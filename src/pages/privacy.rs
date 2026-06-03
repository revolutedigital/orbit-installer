// Orbit Linux — Tela Privacidade (Manifesto)
//
// Esta tela NÃO é configuração de privacidade — é declaração da identidade do
// Orbit. Privacidade no Orbit é INEGOCIÁVEL (regra do projeto, ver CLAUDE.md):
// nada sai da máquina sem opt-in explícito. Não há toggle "habilitar telemetria".
//
// O propósito desta tela é o usuário PARAR antes da instalação final e LER um
// manifesto curto e forte. Não pra ele decidir nada — ele já decidiu instalar
// o Orbit. É pra ele AFIRMAR que entendeu o que o Orbit é.
//
// Inspirado em Pop!_OS, Tails: instaladores que assumem postura editorial sobre
// o que o sistema é, em vez de tratar tudo como configuração técnica.

use crate::prelude::*;

page!(Privacy:
    init(root, sender, model, widgets) {
        root.set_title(None::<&gtk::Window>);
    }

    update(self, message, sender) {} => {}


    gtk::Box {
        set_orientation: gtk::Orientation::Vertical,
        set_spacing: 24,
        set_vexpand: true,
        set_valign: gtk::Align::Center,
        set_halign: gtk::Align::Center,
        set_margin_horizontal: 48,

        // Ícone do manifesto (escudo gravitacional — protege o núcleo "você")
        gtk::Image {
            set_icon_name: Some("security-high-symbolic"),
            inline_css: "-gtk-icon-size: 96px; color: #6C8CFF",
        },

        gtk::Label {
            #[watch]
            set_label: &t!("page-privacy-title"),
            inline_css: "font-weight: bold; font-size: 1.75rem",
            set_justify: gtk::Justification::Center,
        },

        gtk::Label {
            #[watch]
            set_label: &t!("page-privacy-desc-1", distro = crate::CONFIG.read().distro.name.clone()),
            set_justify: gtk::Justification::Center,
            set_max_width_chars: 60,
            set_wrap: true,
        },

        gtk::Label {
            #[watch]
            set_label: &t!("page-privacy-desc-2"),
            set_justify: gtk::Justification::Center,
            set_max_width_chars: 60,
            set_wrap: true,
            inline_css: "opacity: 0.75",
        },
    },

    gtk::Box {
        set_spacing: 4,

        libhelium::Button {
            set_is_pill: true,
            #[watch]
            set_label: &t!("prev"),
            add_css_class: "large-button",
            connect_clicked => PrivacyPageMsg::Navigate(NavigationAction::GoTo(crate::Page::InstallationType))
        },

        gtk::Box {
            set_hexpand: true,
        },

        libhelium::Button {
            set_is_pill: true,
            #[watch]
            set_label: &t!("page-privacy-accept"),
            add_css_class: "suggested-action",
            add_css_class: "large-button",
            connect_clicked => PrivacyPageMsg::Navigate(NavigationAction::GoTo(crate::Page::Confirmation))
        }
    }
);
