// Orbit Linux — Tela Privacidade (Manifesto + opt-in honesto)
//
// Esta tela NÃO é configuração de privacidade no sentido genérico. Privacidade
// no Orbit é INEGOCIÁVEL (regra do projeto, ver CLAUDE.md): nada sai da máquina
// sem opt-in explícito. Mas existem 2 comportamentos que TOCAM a rede e o leigo
// merece DECIDIR conscientemente:
//   1. orbit-auto-update.timer — baixa nova imagem do ghcr.io diariamente (IP
//      visível pro registry). Default ON (correções de CVE), mas com toggle.
//   2. orbit-flathub-setup.service — adiciona remote Flathub no 1º boot pra
//      Discover funcionar. Default ON, com toggle.
//
// Os toggles GRAVAM em /tmp/orbit-privacy-prefs.conf. O postinstall Script
// chroot lê esse arquivo no target e roda systemctl disable conforme.
//
// Inspirado em Pop!_OS, Tails: instaladores que assumem postura editorial.

use crate::prelude::*;
use std::sync::atomic::{AtomicBool, Ordering};

/// Estado dos toggles (default true) — leitura/escrita atômica, sem RefCell.
/// O save_prefs() lê esses globals sempre que algum toggle muda.
static AUTO_UPDATE: AtomicBool = AtomicBool::new(true);
static FLATHUB: AtomicBool = AtomicBool::new(true);

/// Path onde o privacy.rs grava as preferências do usuário.
/// O postinstall Script (em /usr/share/readymade/postinstall.sh) lê este arquivo
/// e roda systemctl disable conforme no target instalado.
const PRIVACY_PREFS_PATH: &str = "/tmp/orbit-privacy-prefs.conf";

fn save_prefs(auto_update: bool, flathub: bool) {
    let content = format!(
        "# Orbit privacy preferences — gravado por orbit-installer privacy.rs.\n\
         # Lido pelo postinstall Script /usr/share/readymade/postinstall.sh.\n\
         ORBIT_PRIVACY_AUTO_UPDATE={}\n\
         ORBIT_PRIVACY_FLATHUB={}\n",
        if auto_update { "true" } else { "false" },
        if flathub { "true" } else { "false" },
    );
    if let Err(e) = std::fs::write(PRIVACY_PREFS_PATH, content) {
        tracing::warn!("Falha gravando privacy prefs em {}: {}", PRIVACY_PREFS_PATH, e);
    }
}

page!(Privacy:
    init(root, sender, model, widgets) {
        root.set_title(None::<&gtk::Window>);
        // Grava prefs default (ambos ON) ANTES do usuário tocar nos switches.
        // Garante que arquivo existe mesmo se ele passar direto sem interagir.
        save_prefs(true, true);
    }

    update(self, message, sender) {} => {}


    gtk::Box {
        set_orientation: gtk::Orientation::Vertical,
        set_spacing: 20,
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

        // ─── v0.2.8 — TOGGLES DE OPT-IN HONESTO ─────────────────────────────
        // Duas coisas que tocam a rede e o leigo merece SABER + DECIDIR.
        // Default ON (recomendado), mas claro o que faz e como desligar.

        // Auto-update toggle
        gtk::Box {
            set_orientation: gtk::Orientation::Horizontal,
            set_spacing: 16,
            set_margin_top: 24,
            inline_css: "background: rgba(108, 140, 255, 0.06); border: 1px solid rgba(108, 140, 255, 0.20); border-radius: 12px; padding: 16px 20px; max-width: 520px;",

            gtk::Box {
                set_orientation: gtk::Orientation::Vertical,
                set_spacing: 4,
                set_hexpand: true,

                gtk::Label {
                    #[watch]
                    set_label: &t!("page-privacy-auto-update-title"),
                    inline_css: "font-weight: bold; font-size: 0.95rem",
                    set_xalign: 0.0,
                },
                gtk::Label {
                    #[watch]
                    set_label: &t!("page-privacy-auto-update-desc"),
                    set_max_width_chars: 50,
                    set_wrap: true,
                    set_xalign: 0.0,
                    inline_css: "font-size: 0.82rem; opacity: 0.78",
                },
            },

            gtk::Switch {
                set_active: true,
                set_valign: gtk::Align::Center,
                connect_state_set => move |_, state| {
                    AUTO_UPDATE.store(state, Ordering::Relaxed);
                    save_prefs(state, FLATHUB.load(Ordering::Relaxed));
                    gtk::glib::Propagation::Proceed
                },
            },
        },

        // Flathub toggle
        gtk::Box {
            set_orientation: gtk::Orientation::Horizontal,
            set_spacing: 16,
            inline_css: "background: rgba(108, 140, 255, 0.06); border: 1px solid rgba(108, 140, 255, 0.20); border-radius: 12px; padding: 16px 20px; max-width: 520px;",

            gtk::Box {
                set_orientation: gtk::Orientation::Vertical,
                set_spacing: 4,
                set_hexpand: true,

                gtk::Label {
                    #[watch]
                    set_label: &t!("page-privacy-flathub-title"),
                    inline_css: "font-weight: bold; font-size: 0.95rem",
                    set_xalign: 0.0,
                },
                gtk::Label {
                    #[watch]
                    set_label: &t!("page-privacy-flathub-desc"),
                    set_max_width_chars: 50,
                    set_wrap: true,
                    set_xalign: 0.0,
                    inline_css: "font-size: 0.82rem; opacity: 0.78",
                },
            },

            gtk::Switch {
                set_active: true,
                set_valign: gtk::Align::Center,
                connect_state_set => move |_, state| {
                    FLATHUB.store(state, Ordering::Relaxed);
                    save_prefs(AUTO_UPDATE.load(Ordering::Relaxed), state);
                    gtk::glib::Propagation::Proceed
                },
            },
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
