function [  ] = move_block( from, to, z_up, z_down )
    CMD_MOVETO([from(1) from(2) z_up 0 0 0]);
    CMD_GRIP_OPEN();
    CMD_MOVETO([from(1) from(2) z_down 0 0 0]);
    CMD_GRIP_CLOSE();
    CMD_MOVETO([from(1) from(2) z_up 0 0 0]);
    CMD_MOVETO([to(1) to(2) z_up 0 0 0]);
    CMD_MOVETO([to(1) to(2) z_down 0 0 0]);
    CMD_GRIP_OPEN();
    CMD_MOVETO([to(1) to(2) z_up 0 0 0]);
end

