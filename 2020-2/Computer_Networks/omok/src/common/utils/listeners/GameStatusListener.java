package omok.src.common.utils.listeners;

import omok.src.common.player.Player;

public interface GameStatusListener {
    void onGameFinished(Player winner);
}
